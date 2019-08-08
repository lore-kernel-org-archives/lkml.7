Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ABAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325392089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ikTsZpqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404662AbfHHXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:06:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404533AbfHHXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:06:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so44938148pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opDMrymB/En0zVOQAsZzeK0WBnbwyQ7DVo+LI/G+0nI=;
        b=ikTsZpqIALXHfXNNPn5q3xwkHzwN31/cjFf8yGaawKBFYr5bEoqwkcLNwNqmnBP3dA
         lyew0kxGzn/wvTC0S6ZqPLMDZ0NxIAWDt+Z8QguV81Gm7yLFJ6Q233iY3boexCsjZoN2
         3Y+CaPJoubQgDiCyBanDym6GLAfqcLDCeDv7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opDMrymB/En0zVOQAsZzeK0WBnbwyQ7DVo+LI/G+0nI=;
        b=sygxuykRrUnSh/sW0n7hMydwa4rXnxGO64vdlZ5FBGU9HOGhwNKgz5MgCtIdpulhCa
         I4kCtAtdrhh4bN4TsiskC9il44xdJmBAQILyrkDwI3RFKcAKg5PpqhTDJDVL10Uj+H2Y
         CrgikUuEgwNARLdj09uRJd2FDVlacq311rYOKFI7QYYWgrdQzgiZW43TgK7dE/N6nMJ6
         Ystgb4kOWMZiDZ/Q3RzUNe7O9p/uw88fBwoSxMa4P2rWjGIAp/5mqgQg5oc1kjnUwLO+
         02ozF0rtxvdmSZ55AtFUOzoEFseDMg9IO1pxFVzsXpOUzIg6CfkmIcRM1STStqiNBv+u
         UEuA==
X-Gm-Message-State: APjAAAX/CFFasZZ1EaeJiXVTvVdBw4q0lRbnJ32Kxg6DJShwu999lKL/
        1stzcJ0fnAPgjO2UEH+RRfA4Og==
X-Google-Smtp-Source: APXvYqxUs/ShSH3NodCVNupDwfPt/CTgZNHs1MZIiS1TQWwVh5q0LUSuD7/p4QawSHP4cg3vnLnTUw==
X-Received: by 2002:a63:61cd:: with SMTP id v196mr15062795pgb.263.1565305594747;
        Thu, 08 Aug 2019 16:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3sm267596pjo.3.2019.08.08.16.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 16:06:33 -0700 (PDT)
Date:   Thu, 8 Aug 2019 16:06:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com>,
        Michael Hund <mhund@ld-didactic.de>, akpm@linux-foundation.org,
        andreyknvl@google.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: BUG: bad usercopy in ld_usb_read
Message-ID: <201908081604.D1203D408@keescook>
References: <0000000000005c056c058f9a5437@google.com>
 <20190808124654.GB32144@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808124654.GB32144@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:46:54PM +0200, Greg KH wrote:
> On Thu, Aug 08, 2019 at 05:38:06AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13aeaece600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=45b2f40f0778cfa7634e
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com
> > 
> > ldusb 6-1:0.124: Read buffer overflow, -131383996186150 bytes dropped
> 
> That's a funny number :)
> 
> Nice overflow found, I see you are now starting to fuzz the char device
> nodes of usb drivers...
> 
> Michael, care to fix this up?

This looks like the length in the read-from-device buffer is unchecked:

        /* actual_buffer contains actual_length + interrupt_in_buffer */
        actual_buffer = (size_t *)(dev->ring_buffer + dev->ring_tail * (sizeof(size_t)+dev->interrupt_in_endpoint_size));
        bytes_to_read = min(count, *actual_buffer);
        if (bytes_to_read < *actual_buffer)
                dev_warn(&dev->intf->dev, "Read buffer overflow, %zd bytes dropped\n",
                         *actual_buffer-bytes_to_read);

        /* copy one interrupt_in_buffer from ring_buffer into userspace */
        if (copy_to_user(buffer, actual_buffer+1, bytes_to_read)) {
                retval = -EFAULT;
                goto unlock_exit;
        }

I assume what's stored at actual_buffer is bogus and needs validation
somewhere before it's actually used. (If not here, maybe where ever the
write into the buffer originally happens?)

-- 
Kees Cook
