Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B056CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F05D20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfDJQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:55:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:36701 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbfDJQzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:55:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 09:55:43 -0700
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="scan'208";a="133131236"
Received: from sbwarrax-mobl1.gar.corp.intel.com (HELO [10.249.46.234]) ([10.249.46.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA; 10 Apr 2019 09:55:40 -0700
Subject: Re: [PATCH 1/2] drm: Add writeback_w,h properties
To:     Ben Davis <Ben.Davis@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1554891327.git.ben.davis@arm.com>
 <4509c625676508caf2b3f5035d901d8fe862fa76.1554891327.git.ben.davis@arm.com>
 <209a6f72-32b6-e546-4fd3-4c27d087d13c@linux.intel.com>
 <20190410164631.GB5105@arm.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <ca3d39bb-0720-f22d-525c-d9732508924e@linux.intel.com>
Date:   Wed, 10 Apr 2019 18:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190410164631.GB5105@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 10-04-2019 om 18:46 schreef Ben Davis:
> On Wed, Apr 10, 2019 at 01:48:51PM +0200, Maarten Lankhorst wrote:
>> Op 10-04-2019 om 13:11 schreef Ben Davis:
>>> Add new properties to specify width and height for writeback.
>>>
>>> Signed-off-by: Ben Davis <ben.davis@arm.com>
>>> ---
>>>  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++++++
>>>  drivers/gpu/drm/drm_writeback.c   | 28 ++++++++++++++++++++++++++++
>>>  include/drm/drm_connector.h       |  4 ++++
>>>  include/drm/drm_mode_config.h     | 10 ++++++++++
>>>  4 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>>> index d520a04..1f68dce 100644
>>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>>> @@ -765,6 +765,10 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>>>  			return -EINVAL;
>>>  		}
>>>  		state->content_protection = val;
>>> +	} else if (property == config->prop_writeback_w) {
>>> +		state->writeback_w = val;
>>> +	} else if (property == config->prop_writeback_h) {
>>> +		state->writeback_h = val;
>>>  	} else if (property == config->writeback_fb_id_property) {
>>>  		struct drm_framebuffer *fb = drm_framebuffer_lookup(dev, NULL, val);
>>>  		int ret = drm_atomic_set_writeback_fb_for_connector(state, fb);
>>> @@ -837,6 +841,10 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>>>  		*val = state->scaling_mode;
>>>  	} else if (property == connector->content_protection_property) {
>>>  		*val = state->content_protection;
>>> +	} else if (property == config->prop_writeback_w) {
>>> +		*val = state->writeback_w;
>>> +	} else if (property == config->prop_writeback_h) {
>>> +		*val = state->writeback_h;
>>>  	} else if (property == config->writeback_fb_id_property) {
>>>  		/* Writeback framebuffer is one-shot, write and forget */
>>>  		*val = 0;
>>> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
>>> index c20e6fe..be42073 100644
>>> --- a/drivers/gpu/drm/drm_writeback.c
>>> +++ b/drivers/gpu/drm/drm_writeback.c
>>> @@ -74,6 +74,12 @@
>>>   *	applications making use of writeback connectors *always* retrieve an
>>>   *	out-fence for the commit and use it appropriately.
>>>   *	From userspace, this property will always read as zero.
>>> + *
>>> + *  "WRITEBACK_W":
>>> + *	The width of the writeback buffer to write back.
>>> + *
>>> + *  "WRITEBACK_H":
>>> + *	The height of the writeback buffer to write back.
>> What happens when they are not set, and left to default 0?
>>
>> ~Maarten
> Hi Maarten,
>
> If they're not set they should be ignored and if writeback is enabled
> it should not be scaled. However you probably shouldn't be able to set
> them as 0, I can add a restriction on that.
I would use 0 as ignored and treat it as the default value.
