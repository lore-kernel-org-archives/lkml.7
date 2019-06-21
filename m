Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1A5C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31B92075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 03:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzfqpCbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFUD5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 23:57:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41574 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUD5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:57:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id p15so7894008eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 20:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzpQ3kjwujWtzVv4DPV/tCEIfc/FEWMVjTdzmC0X/us=;
        b=jzfqpCbIoHgGVRtBrF7lF9LbFU0bamZ0XcWct6qlfHV/QwB10qU/rA1lxfbJzreE4d
         1Eb9Q3vlujL0JdKQ0P5PUa4L684fqSj0w+5LfiZXn3ZB6Ey+OfAyIYoMpv3x967xmxah
         owqCTatdEiWnrqAb92DE1FkUfv1WWYVD9h1fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzpQ3kjwujWtzVv4DPV/tCEIfc/FEWMVjTdzmC0X/us=;
        b=VJz5gSPD8WV1+5IZajBaGpKL9i4xA/jrZZtqw1ScdtvNGUlhxpPOdbg1D4+gYPGXy3
         mOgwedpn8aq0Ly6b48yQcj3cuzRpSo4tSveGOqXiPchX8J52p49NwjdOx+OzmN9VWhpy
         LgLV3oxVyhTc2xj/rS2Rv77n35B2feDIxcmXOYqLlkcas8qp25tJACYtvMkMFy/K2WQu
         EKiv6wCsRtrkraFU8/iUT+2ui+y/4AFuk+f4dt3UnTq4bF8b3SCX5GnstGkbETJX9sEz
         dzujVE5QZIc5DA1kkpwj/jYdUNefmxoUlC1SLGiYUHlW0UYIS5lQHBFj4r2hlYen2hm0
         17AA==
X-Gm-Message-State: APjAAAX29NbI6+dduS1TJLrkHXPL7FHQ1TvC+D/Ad+lM+GFpei5MAn4j
        xgRua08MBdEMQkWyCmA1dlT1KKcSRdRU+mikIRKMPQ==
X-Google-Smtp-Source: APXvYqxtQU/h9lU9BT7NNPLBVdxBj0QGosKYc3X2ZtxZ8KnWLpi5Bn5SLQLGMx+FINNzLp0Eu0dm/II4xxlh1U/V53Y=
X-Received: by 2002:a50:b561:: with SMTP id z30mr89337967edd.87.1561089457646;
 Thu, 20 Jun 2019 20:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
 <1560169080-27134-17-git-send-email-yong.wu@mediatek.com> <CANdKZ0d873PJ2u=Hn_aUJBu3dDiNyueVwBv94-VXHGLJBvAbGg@mail.gmail.com>
 <eee15db0-e43f-de9b-28a0-93bdd04836d7@gmail.com> <effb4fff-da83-708f-ca10-50f2645c91c6@gmail.com>
In-Reply-To: <effb4fff-da83-708f-ca10-50f2645c91c6@gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Fri, 21 Jun 2019 11:57:01 +0800
Message-ID: <CANdKZ0cr=SMtQOTVduKZBOtw5E6ZOpShf3q2McDX=rFWbfB03A@mail.gmail.com>
Subject: Re: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <yingjoe.chen@mediatek.com>,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 7:38 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> CCing Sascha
>
> On 20/06/2019 11:35, Matthias Brugger wrote:
> >
> >
> > On 13/06/2019 10:14, Pi-Hsun Shih wrote:
> >> Hi,
> >> When I tested this patch series (Based on linux 5.2.0-rc2, and with
> >> various other patch series about MT8183) with lockdep enabled, and I'm
> >> seeing the following lockdep warning on boot.
> >>
> >> By bisecting the commits, the first commit that introduce this warning
> >> is this patch. The warning also doesn't appear if
> >> https://lore.kernel.org/patchwork/patch/1086582/ and
> >> https://lore.kernel.org/patchwork/patch/1086583/ are not applied.
> >>
> >> Do anyone have idea on why this is happening, or any suggestion on
> >> which part I should be digging into to figure this out? Thanks.
> >>
> >> [    4.664194] ======================================================
> >> [    4.670368] WARNING: possible circular locking dependency detected
> >> [    4.676545] 5.2.0-rc2-next-20190528-44527-g6c94b6475c04 #20 Tainted: G S
> >> [    4.684539] ------------------------------------------------------
> >> [    4.690714] kworker/4:1/51 is trying to acquire lock:
> >> [    4.695760] (____ptrval____) (regulator_list_mutex){+.+.},
> >> at:regulator_lock_dependent+0xdc/0x6c4
> >> [    4.704732]
> >> [    4.704732] but task is already holding lock:
> >> [    4.710556] (____ptrval____) (&genpd->mlock/1){+.+.},
> >> at:genpd_lock_nested_mtx+0x24/0x30
> >> [    4.718740]
> >> [    4.718740] which lock already depends on the new lock.
> >> [    4.718740]
> >> [    4.726908]
> >> [    4.726908] the existing dependency chain (in reverse order) is:
> >> [    4.734382]
> >> [    4.734382] -> #4 (&genpd->mlock/1){+.+.}:
> >> [    4.739963]        __mutex_lock_common+0x1a0/0x1fe8
> >> [    4.744836]        mutex_lock_nested+0x40/0x50
> >> [    4.749275]        genpd_lock_nested_mtx+0x24/0x30
> >> [    4.754063]        genpd_add_subdomain+0x150/0x524
> >> [    4.758850]        pm_genpd_add_subdomain+0x3c/0x5c
> >> [    4.763723]        scpsys_probe+0x520/0xe78
> >> [    4.767902]        platform_drv_probe+0xf4/0x134
> >> [    4.772517]        really_probe+0x214/0x4dc
> >> [    4.776696]        driver_probe_device+0xcc/0x1d4
> >> [    4.781396]        __device_attach_driver+0x10c/0x180
> >> [    4.786442]        bus_for_each_drv+0x124/0x184
> >> [    4.790968]        __device_attach+0x1c0/0x2d8
> >> [    4.795407]        device_initial_probe+0x20/0x2c
> >> [    4.800106]        bus_probe_device+0x80/0x16c
> >> [    4.804546]        deferred_probe_work_func+0x120/0x168
> >> [    4.809767]        process_one_work+0x858/0x1208
> >> [    4.814379]        worker_thread+0x9ec/0xcb8
> >> [    4.818644]        kthread+0x2b8/0x2d0
> >> [    4.822391]        ret_from_fork+0x10/0x18
> >> [    4.826480]
> >> [    4.826480] -> #3 (&genpd->mlock){+.+.}:
> >> [    4.831880]        __mutex_lock_common+0x1a0/0x1fe8
> >> [    4.836752]        mutex_lock_nested+0x40/0x50
> >> [    4.841190]        genpd_lock_mtx+0x20/0x2c
> >> [    4.845369]        genpd_runtime_resume+0x140/0x434
> >> [    4.850241]        __rpm_callback+0xb0/0x1e4
> >> [    4.854506]        rpm_callback+0x54/0x1a8
> >> [    4.858597]        rpm_resume+0xc6c/0x10c4
> >> [    4.862689]        __pm_runtime_resume+0xb4/0x124
> >> [    4.867387]        device_link_add+0x598/0x8d0
> >
> > For this looks as if you have also patch
> > [PATCH v2 04/12] memory: mtk-smi: Add device-link between smi-larb and smi-common
> > from series
> > [PATCH v2 00/12] Clean up "mediatek,larb" after adding device_link
> > applied.
> >
>
> My guess is, that we run into this, because we call genpd_runtime_resume before
> we have finished the subdomain registration in scpsys_probe.
> That implies that you also have the scpsys series for mt8183 added to your tree.
>
> Anyway it looks to me as if we have to add the subdomains before we call
> of_genpd_add_provider_onecell().
>
> Regards,
> Matthias

Yes I do have scpsys series for mt8183 added in my tree. (I have about
125 patches from list on top of 531b0a360899 "Add linux-next specific
files for 20190528" to make the board boot)
However the exact same warning still exists after I changed the order
of of_genpd_add_provider_onecell and pm_genpd_add_subdomain, patch as
follow:
(Patch is based on commit f4788d37bc84 "Add linux-next specific files
for 20190614")

diff --git a/drivers/soc/mediatek/mtk-scpsys.c
b/drivers/soc/mediatek/mtk-scpsys.c
index 503222d0d0da..0cd9bdd4004e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -440,8 +440,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 static void mtk_register_power_domains(struct platform_device *pdev,
  struct scp *scp, int num)
 {
- struct genpd_onecell_data *pd_data;
- int i, ret;
+ int i;

  for (i = 0; i < num; i++) {
  struct scp_domain *scpd = &scp->domains[i];
@@ -457,18 +456,6 @@ static void mtk_register_power_domains(struct
platform_device *pdev,

  pm_genpd_init(genpd, NULL, false);
  }
-
- /*
- * We are not allowed to fail here since there is no way to unregister
- * a power domain. Once registered above we have to keep the domains
- * valid.
- */
-
- pd_data = &scp->pd_data;
-
- ret = of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
- if (ret)
- dev_err(&pdev->dev, "Failed to add OF provider: %d\n", ret);
 }

 /*
@@ -1053,6 +1040,16 @@ static int scpsys_probe(struct platform_device *pdev)
  ret);
  }

+ /*
+ * We are not allowed to fail here since there is no way to unregister
+ * a power domain. Once registered above we have to keep the domains
+ * valid.
+ */
+
+ ret = of_genpd_add_provider_onecell(pdev->dev.of_node, pd_data);
+ if (ret)
+ dev_err(&pdev->dev, "Failed to add OF provider: %d\n", ret);
+
  return 0;
 }

>
>
> > Regards,
> > Matthias
> >
