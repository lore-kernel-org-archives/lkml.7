Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102AC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19C12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mk7OYxTY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PcjSgTSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfE0Hz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:55:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0Hz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:55:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06C3F60A00; Mon, 27 May 2019 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558943725;
        bh=TLgwZBRAFLM5rcutPPk68tE3qitbgmeVGUN16gHE3Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk7OYxTYrzuAlHczolCGNOP0ozkYjB4Lndk2r9uSDfuBsgeDr+2wpsxn4uCsctyX7
         EJpWL+vAnEzfFDR2P9373hVhVdYUu8XfJOO1qGlpNG/BswI2osGv8xUt2oWAB08SUd
         Ep8qYXptz08qXSI9C0p0EJJiZyjDKUmUYGOInrto=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B58B6086B;
        Mon, 27 May 2019 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558943724;
        bh=TLgwZBRAFLM5rcutPPk68tE3qitbgmeVGUN16gHE3Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcjSgTSMk6k0NRJHID31m2lCvEYJp4utLdfT/RB2lkk+4R8xyEppv9Ykv3wd4Lz72
         S11iKnrKuQWXlDXA6yd8KLsBZf3Z+v/53AXt/awuinTgFTCb5phAN64zBOPsAqdwzC
         XfMXAVYWqVssBxgLAMyUXI7En8MKyBNY3ayQiHcw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B58B6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Mon, 27 May 2019 13:25:18 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <chao@kernel.org>, Yunlei He <heyunlei@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: add errors=panic mount option
Message-ID: <20190527075518.GD10043@codeaurora.org>
References: <1558694631-12481-1-git-send-email-stummala@codeaurora.org>
 <6a4ce8cb-d9ec-1923-8304-6b8956283e85@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4ce8cb-d9ec-1923-8304-6b8956283e85@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:13:50PM +0800, Chao Yu wrote:
> On 2019-5-24 18:43, Sahitya Tummala wrote:
> > Add errors=panic mount option for debugging purpose. It can be
> > set dynamically when the config option CONFIG_F2FS_CHECK_FS
> > is not enabled.
> 
> Sahitya,
> 
> I remember Yunlei has a similar patch for this, could you rebase your code on
> that patch, if Yunlei agrees, we can add Signed-off of him.
> 

Hi Chao,

Sure, I can combine both the patches as they are providing different functionalities
with the same mount option.

Hi Yunlei,

Are you okay with this merging? Please confirm.
If yes, then I will make it into one patch and add your signed-off.

Thanks,

> FYI
> 
> https://sourceforge.net/p/linux-f2fs/mailman/linux-f2fs-devel/thread/f6a0b1c3-4057-8b64-a419-4b2914d48394%40kernel.org/#msg36376331
> 
> Thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> >  fs/f2fs/f2fs.h  |  9 +++++++--
> >  fs/f2fs/super.c | 21 +++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9b3d997..95adedb 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -32,8 +32,12 @@
> >  #define f2fs_bug_on(sbi, condition)					\
> >  	do {								\
> >  		if (unlikely(condition)) {				\
> > -			WARN_ON(1);					\
> > -			set_sbi_flag(sbi, SBI_NEED_FSCK);		\
> > +			if (test_opt(sbi, ERRORS_PANIC)) {		\
> > +				BUG_ON(condition);			\
> > +			} else {					\
> > +				WARN_ON(1);				\
> > +				set_sbi_flag(sbi, SBI_NEED_FSCK);	\
> > +			}						\
> >  		}							\
> >  	} while (0)
> >  #endif
> > @@ -99,6 +103,7 @@ struct f2fs_fault_info {
> >  #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
> >  #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
> >  #define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
> > +#define F2FS_MOUNT_ERRORS_PANIC		0x04000000
> >  
> >  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
> >  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 912e261..7d6d96a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -137,6 +137,7 @@ enum {
> >  	Opt_fsync,
> >  	Opt_test_dummy_encryption,
> >  	Opt_checkpoint,
> > +	Opt_errors,
> >  	Opt_err,
> >  };
> >  
> > @@ -196,6 +197,7 @@ enum {
> >  	{Opt_fsync, "fsync_mode=%s"},
> >  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> >  	{Opt_checkpoint, "checkpoint=%s"},
> > +	{Opt_errors, "errors=%s"},
> >  	{Opt_err, NULL},
> >  };
> >  
> > @@ -788,6 +790,23 @@ static int parse_options(struct super_block *sb, char *options)
> >  			}
> >  			kvfree(name);
> >  			break;
> > +		case Opt_errors:
> > +#ifndef CONFIG_F2FS_CHECK_FS
> > +			name = match_strdup(&args[0]);
> > +			if (!name)
> > +				return -ENOMEM;
> > +
> > +			if (strlen(name) == 5 && !strncmp(name, "panic", 5)) {
> > +				set_opt(sbi, ERRORS_PANIC);
> > +			} else {
> > +				kvfree(name);
> > +				return -EINVAL;
> > +			}
> > +			kvfree(name);
> > +			f2fs_msg(sb, KERN_INFO,
> > +				"debug mode errors=panic enabled\n");
> > +#endif
> > +			break;
> >  		default:
> >  			f2fs_msg(sb, KERN_ERR,
> >  				"Unrecognized mount option \"%s\" or missing value",
> > @@ -1417,6 +1436,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >  		seq_printf(seq, ",fsync_mode=%s", "strict");
> >  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_NOBARRIER)
> >  		seq_printf(seq, ",fsync_mode=%s", "nobarrier");
> > +	if (test_opt(sbi, ERRORS_PANIC))
> > +		seq_printf(seq, ",errors=%s", "panic");
> >  	return 0;
> >  }
> >  
> > 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
