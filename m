Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E223C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A922087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 05:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdeIxS3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfDTFnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 01:43:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfDTFnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 01:43:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3378301pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 22:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wvDkm/FFYTxTL/exzKddv47jWPcNYlgL1IXbJ6bY44=;
        b=AdeIxS3fuOKqVxI497lsIy83mPko/CtKpEtr7yMOY/Px18/vvGGBQWtMSA1ask2lMQ
         j8LK1G1C2NRkEE0W0cpm4CtnrFRtWIAKIF16X4sV63me1pBzvmq4Sogk8SlaEHBqneaj
         cs4QBtYLktcR17gq85wYrMsk8SLpPOFIIJ2KHeZVsUOyCn4dQNXek160gqi8R7i4bNct
         xq7BjmdglgRWF2+HZfb8lPAW2JO6fvSbz3DFn393i7WRqMVl1lmKtcqB1rwzJFrDqFoE
         kNw9FjcsmK+mi4lLmCDTMjmEIDxxLcwU6ZgFZ0dXLl8hOxKDvlb5hnZewgO5EisWhzOj
         sdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wvDkm/FFYTxTL/exzKddv47jWPcNYlgL1IXbJ6bY44=;
        b=hQFPRN9+01ND+gJqCw2jZWW16PlMEWrxeD/80Eng5o87e0DTFcvxcbcHuWS/y9e8pV
         PwVbvMCvD7Epjka+23RIke9MbN2zIyGJCk9zcte8FyVD1RbtTySnYW2Ac67BYljHaPEc
         42tX4AKkLLYmA/HLh5FTAeSvtGxUuGICpfOkVdBeo0HLoSfDsxXymby6sNNhaOqWrjuI
         jn5uIS+HoWT82e2y6hzUq4WWT6ytFVJy4QiMBmg2WtqjD2aA3VubCvI04xtVGPGce82N
         5tPLgadqvhhFHx/CjZ51A2ZPZTsL8cZ6Dl2EnXYi3k8vmF6D12yWrp1mCM82VPqor1E3
         mGgw==
X-Gm-Message-State: APjAAAV3Ttx8tHZymA4Qa+YTKuKpwE9tvY0R5HhS/STFIX5PTN7jbbHY
        TcfsLdTF/9O//tb340FPTpLduD7GNfhATDxZSGs=
X-Google-Smtp-Source: APXvYqzBBr1vPxGn5f32CGhfokbVSyZPGvOkU27nDX5Ba6jAYf6aACWDusz4JS71u1nGcBwn69R44IiC3wPdo5kUWLQ=
X-Received: by 2002:a62:a515:: with SMTP id v21mr8243683pfm.41.1555738995714;
 Fri, 19 Apr 2019 22:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190418220229.32133-1-tony.luck@intel.com> <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic> <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
In-Reply-To: <20190419002645.GA559@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 19 Apr 2019 22:43:03 -0700
Message-ID: <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 5:26 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Now, if any of that above still doesn't make it clear, please state what
> you're trying to achieve and I'll try to help.

Sorry that I misled you to believe we don't even enable
CONFIG_X86_MCELOG_LEGACY. Here is what we have and
what we have tried:

1. We have CONFIG_X86_MCELOG_LEGACY=y

2. We also have CONFIG_RAS=y and CONFIG_RAS_CEC=y

3. mcelog started as a daemon successfully, like before

4. Some real correctable memory errors happened, as logged in
dmesg

5. mcelog couldn't receive any of them, reported 0 errors

6. Admin's complained to us as they believe this is a kernel bug

7. We dug into kernel source code and found out CONFIG_RAS
hijacks all these errors, by stopping there in the notification chain:

static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
                              void *data)
{
        struct mce *m = (struct mce *)data;

        if (!m)
                return NOTIFY_DONE;

        if (cec_add_mce(m))
                return NOTIFY_STOP; // <=== Returns and stops here

        /* Emit the trace record: */
        trace_mce_record(m);

        set_bit(0, &mce_need_notify);

        mce_notify_irq(); // <=== There is where MCELOG receives

        return NOTIFY_DONE;
}


8. I noticed rasdaemon, and tried to start it instead of mcelog.

9. I injected some memory error and could successfully read them
via ras-mc-ctl.

To demonstrate what I think we should have, here is the PoC code
ONLY to show the idea (please don't judge it):


@ -567,12 +567,12 @@ static int mce_first_notifier(struct
notifier_block *nb, unsigned long val,
                              void *data)
 {
        struct mce *m = (struct mce *)data;
+       bool consumed;

        if (!m)
                return NOTIFY_DONE;

-       if (cec_add_mce(m))
-               return NOTIFY_STOP;
+       consumed = cec_add_mce(m);

        /* Emit the trace record: */
        trace_mce_record(m);
@@ -581,7 +581,7 @@ static int mce_first_notifier(struct
notifier_block *nb, unsigned long val,

        mce_notify_irq();

-       return NOTIFY_DONE;
+       return consumed ? NOTIFY_STOP : NOTIFY_DONE;
 }

With this change, although not even compiled, mcelog should still
receive correctable memory errors like before, even when we have
CONFIG_RAS_CEC=y.

Does this make any sense to you?

Thanks!
