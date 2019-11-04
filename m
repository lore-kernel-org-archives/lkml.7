Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92BCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AC22467
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfKDJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:29:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:50239 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfKDJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:29:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 01:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="401550886"
Received: from savicrad-mobl.ger.corp.intel.com (HELO [10.249.40.217]) ([10.249.40.217])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2019 01:29:36 -0800
Subject: Re: [PATCH 1/2] drm/atomic: fix self-refresh helpers crtc state
 dereference
To:     Sean Paul <sean@poorly.run>, Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20191101180713.5470-1-robdclark@gmail.com>
 <CAMavQKKMjge6MwH=-DS5Ngs8ZE5G_x_Vncy+YoqYrC0s0AfX=Q@mail.gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <3a67eed5-8be7-df5b-84fa-61b133e1fea2@linux.intel.com>
Date:   Mon, 4 Nov 2019 10:29:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMavQKKMjge6MwH=-DS5Ngs8ZE5G_x_Vncy+YoqYrC0s0AfX=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 01-11-2019 om 21:06 schreef Sean Paul:
> On Fri, Nov 1, 2019 at 2:09 PM Rob Clark <robdclark@gmail.com> wrote:
>> From: Rob Clark <robdclark@chromium.org>
>>
>> drm_self_refresh_helper_update_avg_times() was incorrectly accessing the
>> new incoming state after drm_atomic_helper_commit_hw_done().  But this
>> state might have already been superceeded by an !nonblock atomic update
>> resulting in dereferencing an already free'd crtc_state.
>>
>> Fixes: d4da4e33341c ("drm: Measure Self Refresh Entry/Exit times to avoid thrashing")
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>> TODO I *think* this will more or less do the right thing.. althought I'm
>> not 100% sure if, for example, we enter psr in a nonblock commit, and
>> then leave psr in a !nonblock commit that overtakes the completion of
>> the nonblock commit.  Not sure if this sort of scenario can happen in
>> practice.  But not crashing is better than crashing, so I guess we
>> should either take this patch or rever the self-refresh helpers until
>> Sean can figure out a better solution.
>>
>>  drivers/gpu/drm/drm_atomic_helper.c       |  2 ++
>>  drivers/gpu/drm/drm_self_refresh_helper.c | 11 ++++++-----
>>  include/drm/drm_atomic.h                  |  8 ++++++++
>>  3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> index 3ef2ac52ce94..732bd0ce9241 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -2240,6 +2240,8 @@ void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
>>         int i;
>>
>>         for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>> +               old_state->crtcs[i].new_self_refresh_active = new_crtc_state->self_refresh_active;
>> +
>>                 commit = new_crtc_state->commit;
>>                 if (!commit)
>>                         continue;
>> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
>> index 68f4765a5896..77b9079fa578 100644
>> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
>> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
>> @@ -143,19 +143,20 @@ void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
>>                                               unsigned int commit_time_ms)
>>  {
>>         struct drm_crtc *crtc;
>> -       struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>> +       struct drm_crtc_state *old_crtc_state;
>>         int i;
>>
>> -       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
>> -                                     new_crtc_state, i) {
>> +       for_each_old_crtc_in_state(state, crtc, old_crtc_state, i) {
>> +               bool new_self_refresh_active =
>> +                               state->crtcs[i].new_self_refresh_active;
>>                 struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
>>                 struct ewma_psr_time *time;
>>
>>                 if (old_crtc_state->self_refresh_active ==
>> -                   new_crtc_state->self_refresh_active)
>> +                   new_self_refresh_active)
>>                         continue;
>>
>> -               if (new_crtc_state->self_refresh_active)
>> +               if (new_self_refresh_active)
>>                         time = &sr_data->entry_avg_ms;
>>                 else
>>                         time = &sr_data->exit_avg_ms;
>> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
>> index 927e1205d7aa..86baf2b38bb3 100644
>> --- a/include/drm/drm_atomic.h
>> +++ b/include/drm/drm_atomic.h
>> @@ -155,6 +155,14 @@ struct __drm_crtcs_state {
>>         struct drm_crtc *ptr;
>>         struct drm_crtc_state *state, *old_state, *new_state;
>>
>> +       /**
>> +        * @new_self_refresh_active:
>> +        *
>> +        * drm_atomic_helper_commit_hw_done() stashes new_crtc_state->self_refresh_active
>> +        * so that it can be accessed late in drm_self_refresh_helper_update_avg_times().
>> +        */
>> +       bool new_self_refresh_active;
>> +
> Instead of stashing this in crtc, we could generate a bitmask local to
> commit_tail and pass that to calc_avg_times? That way we don't have to
> worry about someone using this when they shouldn't

Yeah would make sense to have a bitmask, instead of making the property special. :)

Current solution seems a bit ugly.


