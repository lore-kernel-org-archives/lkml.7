Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E62C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59EC20B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfXBw9LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfHJSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 14:23:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43730 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 14:23:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so47710402pfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1wMbnmcvYThr8v75tXw+NLJxxgTL8aTm8bPoijuWeXk=;
        b=CfXBw9LLS2F5CcDSorlej7BcL3a8HeAP9pALu5KvwWwkMSPiuKBuVIY9XQmieFUYCE
         lFxYg0yhxmEmzZCTXKoFTjfqBxXQsPTI1k2u20Amu4jFI6EvtZeKX7o+G7ygYkeu9GJf
         w/8ZmCDP/svUHzPv4FGiys1oJaPjVepGIg1vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wMbnmcvYThr8v75tXw+NLJxxgTL8aTm8bPoijuWeXk=;
        b=XlwBAeqlbpddL7SbSfo7gMsHmICPcFZwhnAPZQ1Junor7qk28Oqn5GmZmKxYYSGB0E
         OYPCzS/96/AmJ1JeFqIhQd6f4+hATKDF39729Qh4z+plssV5pAnNCUoGEp3gnhw79iZo
         o5beRDOmG3aOmwPiStXmXmmWtXikfr9V3PCnYGgZJs1NkRQ/NV6bMddJs2MXSvAk8czd
         kGczUWcoAe+gobg7/lCAr8Zn6reeZsGnEa6CRV9AQ/xkKTLdWPLMBBcwV/WZKIJtKB9Z
         JJUClNXLtSetmn55iNKsauoOXEcyTXsP3PWk/kASswv7bhEQ08fd9EbBnQqyLWGpPh47
         okcw==
X-Gm-Message-State: APjAAAVtUApA1mX6Tb/DK48GMzvEF+jWFc07PqAJ5B3rIGYQFsFdIZjz
        ab9JLUVCLuQPCEBhhMTRX4N/qA==
X-Google-Smtp-Source: APXvYqwv9kKazhsFHfQH/poO6zFrpDEO8Q9vVz6A2xAvqR+Dr3CXy+nbi3/t+heCuUrDlMSmH7frYw==
X-Received: by 2002:a17:90a:bf03:: with SMTP id c3mr14911536pjs.112.1565461400408;
        Sat, 10 Aug 2019 11:23:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm72180032pgh.61.2019.08.10.11.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Aug 2019 11:23:19 -0700 (PDT)
Date:   Sat, 10 Aug 2019 11:23:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+45b2f40f0778cfa7634e@syzkaller.appspotmail.com>,
        Michael Hund <mhund@ld-didactic.de>, akpm@linux-foundation.org,
        andreyknvl@google.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: BUG: bad usercopy in ld_usb_read
Message-ID: <201908101120.BE5034521A@keescook>
References: <20190809085545.GB21320@kroah.com>
 <Pine.LNX.4.44L0.1908091100580.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1908091100580.1630-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:13:00AM -0400, Alan Stern wrote:
> In fact, I don't see why any of the computations here should overflow
> or wrap around, or even give rise to a negative value.  If syzbot had a
> reproducer we could get more debugging output -- but it doesn't.

Yeah, this is odd. The only thing I could see here with more study was
that ring_tail is used/updated outside of the rbsl lock in
ld_usb_read(). I couldn't convince myself there wasn't a race against
the interrupt, but I also couldn't think of a way it could break...

-- 
Kees Cook
