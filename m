Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB89C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B828E20659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MCb1Z2D3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e+h2bnNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfFYFor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:44:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfFYFor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:44:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1BF25601E7; Tue, 25 Jun 2019 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561441486;
        bh=VoP64LnBzSeu4YlaPxe3/Iim6Cic7+1v38v1apbRuak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MCb1Z2D3EruYT8t2nRPe3btLfwqWxn+9pHYZ81bQ8T1Bz1HpQQl76TdVE+yZM1SY/
         evJ8li6Bc+C4+FgFC5FWIo75ysmuo3puw8fljJKa6uYn0zFhujbq64EvPtPRG4dv0R
         DoUwyg7DtSN5c4hF8ICg6wxq9dbxHUlnJxVp9JAs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 52BAF601E7;
        Tue, 25 Jun 2019 05:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561441485;
        bh=VoP64LnBzSeu4YlaPxe3/Iim6Cic7+1v38v1apbRuak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+h2bnNqJO4uHAEkcwB1UFdosHbAILF0sslm8yXSoJdwAxpG0yu4ZXtumIN4VwMTt
         QbxTp+wvqlBrQQhzR4n/CQ6iAqTUO+6PU1BE6OqWORC/CdVbTYJ8rCDZuIgoh3Sqt1
         wJmGLediQfgaML9iTnIv2fwJt4ZHHQPEobkS++NA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jun 2019 11:14:45 +0530
From:   dhar@codeaurora.org
To:     Jeykumar Sankaran <jsanka@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        nganji@codeaurora.org, jshekhar@codeaurora.org
Subject: Re: drm/msm/dpu: Correct dpu encoder spinlock initialization
In-Reply-To: <efade579f7ba59585b88ecb367422e5c@codeaurora.org>
References: <1561357632-15361-1-git-send-email-dhar@codeaurora.org>
 <efade579f7ba59585b88ecb367422e5c@codeaurora.org>
Message-ID: <d61d7805b4ac0ec45309bf5b65841262@codeaurora.org>
X-Sender: dhar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25 03:56, Jeykumar Sankaran wrote:
> On 2019-06-23 23:27, Shubhashree Dhar wrote:
>> dpu encoder spinlock should be initialized during dpu encoder
>> init instead of dpu encoder setup which is part of commit.
>> There are chances that vblank control uses the uninitialized
>> spinlock if not initialized during encoder init.
> Not much can be done if someone is performing a vblank operation
> before encoder_setup is done.
> Can you point to the path where this lock is acquired before
> the encoder_setup?
> 
> Thanks
> Jeykumar S.
>> 

When running some dp usecase, we are hitting this callstack.

Process kworker/u16:8 (pid: 215, stack limit = 0x00000000df9dd930)
Call trace:
  spin_dump+0x84/0x8c
  spin_dump+0x0/0x8c
  do_raw_spin_lock+0x80/0xb0
  _raw_spin_lock_irqsave+0x34/0x44
  dpu_encoder_toggle_vblank_for_crtc+0x8c/0xe8
  dpu_crtc_vblank+0x168/0x1a0
  dpu_kms_enable_vblank+0[   11.648998]  vblank_ctrl_worker+0x3c/0x60
  process_one_work+0x16c/0x2d8
  worker_thread+0x1d8/0x2b0
  kthread+0x124/0x134

Looks like vblank is getting enabled earlier causing this issue and we 
are using the spinlock without initializing it.

Thanks,
Shubhashree

>> Change-Id: I5a18b95fa47397c834a266b22abf33a517b03a4e
>> Signed-off-by: Shubhashree Dhar <dhar@codeaurora.org>
>> ---
>>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 5f085b5..22938c7 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -2195,8 +2195,6 @@ int dpu_encoder_setup(struct drm_device *dev, 
>> struct
>> drm_encoder *enc,
>>  	if (ret)
>>  		goto fail;
>> 
>> -	spin_lock_init(&dpu_enc->enc_spinlock);
>> -
>>  	atomic_set(&dpu_enc->frame_done_timeout, 0);
>>  	timer_setup(&dpu_enc->frame_done_timer,
>>  			dpu_encoder_frame_done_timeout, 0);
>> @@ -2250,6 +2248,7 @@ struct drm_encoder *dpu_encoder_init(struct
>> drm_device *dev,
>> 
>>  	drm_encoder_helper_add(&dpu_enc->base, &dpu_encoder_helper_funcs);
>> 
>> +	spin_lock_init(&dpu_enc->enc_spinlock);
>>  	dpu_enc->enabled = false;
>> 
>>  	return &dpu_enc->base;


