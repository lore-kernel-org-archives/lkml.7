Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD37C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9DC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391240AbfFJPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:39:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390073AbfFJPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEE13344;
        Mon, 10 Jun 2019 08:39:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82E593F246;
        Mon, 10 Jun 2019 08:39:56 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 44A1F682413; Mon, 10 Jun 2019 16:39:55 +0100 (BST)
Date:   Mon, 10 Jun 2019 16:39:55 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/vkms: Add support for writeback
Message-ID: <20190610153955.GI4173@e110455-lin.cambridge.arm.com>
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <0acd74232d988970668298be0111c485bc68ec87.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607074808.GC21222@phenom.ffwll.local>
 <CADKXj+6uBWtk2X5eSz=ce4Rb7USnkEPtUkBBefORHJGuemptwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADKXj+6uBWtk2X5eSz=ce4Rb7USnkEPtUkBBefORHJGuemptwA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 11:58:04AM -0300, Rodrigo Siqueira wrote:
> On Fri, Jun 7, 2019 at 4:48 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Jun 06, 2019 at 07:41:01PM -0300, Rodrigo Siqueira wrote:
> > > This patch implements the necessary functions to add writeback support
> > > for vkms. This feature is useful for testing compositors if you don’t
> > > have hardware with writeback support.
> > >
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > ---
> > >  drivers/gpu/drm/vkms/Makefile         |   9 +-
> > >  drivers/gpu/drm/vkms/vkms_crtc.c      |   5 +
> > >  drivers/gpu/drm/vkms/vkms_drv.c       |  10 ++
> > >  drivers/gpu/drm/vkms/vkms_drv.h       |  12 ++
> > >  drivers/gpu/drm/vkms/vkms_output.c    |   6 +
> > >  drivers/gpu/drm/vkms/vkms_writeback.c | 165 ++++++++++++++++++++++++++
> > >  6 files changed, 206 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> > >
> > > diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> > > index 89f09bec7b23..90eb7acd618d 100644
> > > --- a/drivers/gpu/drm/vkms/Makefile
> > > +++ b/drivers/gpu/drm/vkms/Makefile
> > > @@ -1,4 +1,11 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > -vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_crc.o
> > > +vkms-y := \
> > > +     vkms_drv.o \
> > > +     vkms_plane.o \
> > > +     vkms_output.o \
> > > +     vkms_crtc.o \
> > > +     vkms_gem.o \
> > > +     vkms_crc.o \
> > > +     vkms_writeback.o
> > >
> > >  obj-$(CONFIG_DRM_VKMS) += vkms.o
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > index 1bbe099b7db8..ce797e265b1b 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -23,6 +23,11 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
> > >       if (!ret)
> > >               DRM_ERROR("vkms failure on handling vblank");
> > >
> > > +     if (output->writeback_status == WB_START) {
> > > +             drm_writeback_signal_completion(&output->wb_connector, 0);
> > > +             output->writeback_status = WB_STOP;
> > > +     }
> > > +
> > >       if (state && output->crc_enabled) {
> > >               u64 frame = drm_crtc_accurate_vblank_count(crtc);
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> > > index 92296bd8f623..d5917d5a45e3 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > > @@ -29,6 +29,10 @@ bool enable_cursor;
> > >  module_param_named(enable_cursor, enable_cursor, bool, 0444);
> > >  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
> > >
> > > +int enable_writeback;
> > > +module_param_named(enable_writeback, enable_writeback, int, 0444);
> > > +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
> > > +
> > >  static const struct file_operations vkms_driver_fops = {
> > >       .owner          = THIS_MODULE,
> > >       .open           = drm_open,
> > > @@ -123,6 +127,12 @@ static int __init vkms_init(void)
> > >               goto out_fini;
> > >       }
> > >
> > > +     vkms_device->output.writeback_status = WB_DISABLED;
> > > +     if (enable_writeback) {
> > > +             vkms_device->output.writeback_status = WB_STOP;
> > > +             DRM_INFO("Writeback connector enabled");
> > > +     }
> > > +
> > >       ret = vkms_modeset_init(vkms_device);
> > >       if (ret)
> > >               goto out_fini;
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > > index e81073dea154..ca1f9ee63ec8 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > > @@ -7,6 +7,7 @@
> > >  #include <drm/drm.h>
> > >  #include <drm/drm_gem.h>
> > >  #include <drm/drm_encoder.h>
> > > +#include <drm/drm_writeback.h>
> > >  #include <linux/hrtimer.h>
> > >
> > >  #define XRES_MIN    20
> > > @@ -60,14 +61,22 @@ struct vkms_crtc_state {
> > >       u64 frame_end;
> > >  };
> > >
> > > +enum wb_status {
> > > +     WB_DISABLED,
> > > +     WB_START,
> > > +     WB_STOP,
> > > +};
> > > +
> > >  struct vkms_output {
> > >       struct drm_crtc crtc;
> > >       struct drm_encoder encoder;
> > >       struct drm_connector connector;
> > > +     struct drm_writeback_connector wb_connector;
> > >       struct hrtimer vblank_hrtimer;
> > >       ktime_t period_ns;
> > >       struct drm_pending_vblank_event *event;
> > >       bool crc_enabled;
> > > +     enum wb_status writeback_status;
> > >       /* ordered wq for crc_work */
> > >       struct workqueue_struct *crc_workq;
> > >       /* protects concurrent access to crc_data */
> > > @@ -141,4 +150,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
> > >                          size_t *values_cnt);
> > >  void vkms_crc_work_handle(struct work_struct *work);
> > >
> > > +/* Writeback */
> > > +int enable_writeback_connector(struct vkms_device *vkmsdev);
> > > +
> > >  #endif /* _VKMS_DRV_H_ */
> > > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> > > index 1442b447c707..1fc1d4e9585c 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > > @@ -91,6 +91,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
> > >               goto err_attach;
> > >       }
> > >
> > > +     if (vkmsdev->output.writeback_status != WB_DISABLED) {
> > > +             ret = enable_writeback_connector(vkmsdev);
> > > +             if (ret)
> > > +                     DRM_ERROR("Failed to init writeback connector\n");
> > > +     }
> > > +
> > >       drm_mode_config_reset(dev);
> > >
> > >       return 0;
> > > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> > > new file mode 100644
> > > index 000000000000..f7b962ae5646
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > > @@ -0,0 +1,165 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include "vkms_drv.h"
> > > +#include <drm/drm_writeback.h>
> > > +#include <drm/drm_probe_helper.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_gem_framebuffer_helper.h>
> > > +
> > > +static const struct drm_connector_funcs vkms_wb_connector_funcs = {
> > > +     .fill_modes = drm_helper_probe_single_connector_modes,
> > > +     .destroy = drm_connector_cleanup,
> > > +     .reset = drm_atomic_helper_connector_reset,
> > > +     .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > +     .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > +};
> > > +
> > > +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> > > +                                     struct drm_crtc_state *crtc_state,
> > > +                                     struct drm_connector_state *conn_state)
> > > +{
> > > +     struct drm_framebuffer *fb;
> > > +     const struct drm_display_mode *mode = &crtc_state->mode;
> > > +
> > > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> > > +             return 0;
> > > +
> > > +     fb = conn_state->writeback_job->fb;
> > > +     if (fb->width != mode->hdisplay || fb->height != mode->vdisplay) {
> > > +             DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> > > +                           fb->width, fb->height);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     if (fb->format->format != DRM_FORMAT_XRGB8888) {
> > > +             struct drm_format_name_buf format_name;
> > > +
> > > +             DRM_DEBUG_KMS("Invalid pixel format %s\n",
> > > +                           drm_get_format_name(fb->format->format,
> > > +                                               &format_name));
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_funcs = {
> > > +     .atomic_check = vkms_wb_encoder_atomic_check,
> > > +};
> > > +
> > > +static int vkms_wb_connector_get_modes(struct drm_connector *connector)
> > > +{
> > > +     struct drm_device *dev = connector->dev;
> > > +
> > > +     return drm_add_modes_noedid(connector, dev->mode_config.max_width,
> > > +                                 dev->mode_config.max_height);
> > > +}
> > > +
> > > +static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
> > > +                            struct drm_writeback_job *job)
> > > +{
> > > +     struct vkms_gem_object *vkms_obj;
> > > +     struct drm_gem_object *gem_obj;
> > > +     int ret;
> > > +
> > > +     if (!job->fb)
> > > +             return 0;
> > > +
> > > +     gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> > > +     ret = vkms_gem_vmap(gem_obj);
> > > +     if (ret) {
> > > +             DRM_ERROR("vmap failed: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> > > +     job->priv = vkms_obj->vaddr;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
> > > +                             struct drm_writeback_job *job)
> > > +{
> > > +     struct drm_gem_object *gem_obj;
> > > +
> > > +     if (!job->fb)
> > > +             return;
> > > +
> > > +     gem_obj = drm_gem_fb_get_obj(job->fb, 0);
> > > +     vkms_gem_vunmap(gem_obj);
> > > +}
> > > +
> > > +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> > > +                               struct drm_connector_state *state)
> > > +{
> > > +     struct vkms_device *vkmsdev = drm_device_to_vkms_device(conn->dev);
> > > +     struct vkms_output *output = &vkmsdev->output;
> > > +     struct drm_writeback_connector *wb_conn = &output->wb_connector;
> > > +     struct drm_connector_state *conn_state = wb_conn->base.state;
> > > +     void *priv_data = conn_state->writeback_job->priv;
> > > +     struct vkms_crc_data *primary_data = NULL;
> > > +     struct drm_framebuffer *fb = NULL;
> > > +     struct vkms_gem_object *vkms_obj;
> > > +     struct drm_gem_object *gem_obj;
> > > +     struct drm_plane *plane;
> > > +
> > > +     if (!conn_state)
> > > +             return;
> > > +
> > > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb) {
> > > +             output->writeback_status = WB_STOP;
> > > +             DRM_DEBUG_DRIVER("Disable writeback\n");
> > > +             return;
> > > +     }
> > > +
> > > +     drm_for_each_plane(plane, &vkmsdev->drm) {
> > > +             struct vkms_plane_state *vplane_state;
> > > +             struct vkms_crc_data *plane_data;
> > > +
> > > +             vplane_state = to_vkms_plane_state(plane->state);
> > > +             plane_data = vplane_state->crc_data;
> > > +
> > > +             if (drm_framebuffer_read_refcount(&plane_data->fb) == 0)
> > > +                     continue;
> > > +
> > > +             if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> > > +                     primary_data = plane_data;
> > > +     }
> > > +
> > > +     if (!primary_data)
> > > +             return;
> > > +
> > > +     fb = &primary_data->fb;
> > > +     gem_obj = drm_gem_fb_get_obj(fb, 0);
> > > +     vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> > > +
> > > +     if (!vkms_obj->vaddr || !priv_data)
> > > +             return;
> > > +
> > > +     memcpy(priv_data, vkms_obj->vaddr, vkms_obj->gem.size);
> > > +     drm_writeback_queue_job(wb_conn, state);
> > > +     output->writeback_status = WB_START;
> >
> > Hm, if this passes the current writeback tests then I guess those tests
> > are a bit too simple. Or maybe the test can't use the cursor plane, and
> > that's why it doesn't notice that we only write back the primary plane.
> 
> Hi,

Hi Rodrigo,

> 
> Sorry, I knew about that, and I should have highlighted this
> information in the cover letter. In my original plan, I wanted to land
> a basic version of writeback in the vkms to try to upstream the
> kms_writeback; then I wish that I could improve vkms and the tests in
> parallel.
> 
> In summary, the kms_writeback is not upstream yet, and it needs some
> improvements. IHMO, we should try to upstream the current version and
> improve it step-by-step by using VKMS. If Brian and Liviu agree, I
> would like to try to send a new version of their patchset. What do you
> think?

I'll be happy to see the changes you've made to kms_writeback tests. I have
some stashed changes that were addressing the latest comments I've got, so if
we coordinate we should be able to release a new version of the patchset for
the tests that hopefully will get merged.

Best regards,
Liviu

> 
> Daniel, about your patchset (drm/vkms: rework crc worker), just give
> me a time to go through your patchset. After that, I'll make the
> required changes and update the writeback.
> 
> Thank you all for the feedback. I'll prepare a V2 with all the suggestions.
> 
> > Writeback is supposed to write back the same image you'd see on the
> > screen, i.e. with cursor, other planes, any color correction applied and
> > anything else really. That means vkms writeback needs to be integrated
> > into the crc computation. We need to run that work either when there's a
> > writeback job or when we need a crc. Crc would be only computed when
> > needed, and for writeback we need to put the entire composited/blended
> > buffer into the writeback buffer.
> >
> > That's why I said yesterday that your work will conflict with my work to
> > reorg crc work handling, aside from the final step it needs to do all the
> > same things.
> >
> > I guess would be good to improve igt and add a cursor testcase for write
> > (similar to the crc cursor tests we have), or maybe create support in igt
> > to use writeback instead of crc, so that we could better check this.
> > -Daniel
> >
> > > +}
> > > +
> > > +static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
> > > +     .get_modes = vkms_wb_connector_get_modes,
> > > +     .prepare_writeback_job = vkms_wb_prepare_job,
> > > +     .cleanup_writeback_job = vkms_wb_cleanup_job,
> > > +     .atomic_commit = vkms_wb_atomic_commit,
> > > +};
> > > +
> > > +int enable_writeback_connector(struct vkms_device *vkmsdev)
> > > +{
> > > +     struct drm_writeback_connector *wb = &vkmsdev->output.wb_connector;
> > > +
> > > +     vkmsdev->output.wb_connector.encoder.possible_crtcs = 1;
> > > +     drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> > > +
> > > +     return drm_writeback_connector_init(&vkmsdev->drm, wb,
> > > +                                         &vkms_wb_connector_funcs,
> > > +                                         &vkms_wb_encoder_helper_funcs,
> > > +                                         vkms_formats,
> > > +                                         ARRAY_SIZE(vkms_formats));
> > > +}
> > > +
> > > --
> > > 2.21.0
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> 
> 
> -- 
> 
> Rodrigo Siqueira
> https://siqueira.tech

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
