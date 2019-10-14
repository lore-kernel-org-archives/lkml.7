Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46322ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201C120854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4Sv0nu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbfJNOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:44:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54626 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:44:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so17578225wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lV9WUHRQYa+vcbnXaIrl9dHPzPBQxfzmjkh8HTlj1Bg=;
        b=R4Sv0nu/0zTthcOB5gdAeVN4GjOy9iItL0K/CL5nKP+gYb8+0NlbvVtDbWrASvGTFg
         Xq15G3Gif4VH+0edHvuVUs3yIveqxdNZS+8W6cN8Flbst2a09CdpfrX6aj/yKZ1HvxOG
         cQU1WqMXDcgvms+37/3cqYRyAB5jN2IxSxkEyEBgja6lyNdKXHm0CEv1CMkA8A+C5OWg
         43HJiqe22PxAK/W1GQfdSX6aDYU4+E4RJnH8Y8nwGD/OLM46seNi4tRfEWtaWljw1njn
         v6hKrQOmlP1FYMfLEPltHPE+Lmo/zYA5/AtOZspeSJfUN9bqOQMmuTW+F49uO98xA3J+
         dvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lV9WUHRQYa+vcbnXaIrl9dHPzPBQxfzmjkh8HTlj1Bg=;
        b=VlqP1eA6Y10vO+Fnu/1+6nuoDzoAvCHAdpwS8SdZf+dIiR4BI+OzCgzV4PjUylKsDz
         RVwj+1Sv703O/EnVqssFY31OP5TQu+iZ9Oe44+wmXUnegd9vOsX5xQPqPmeDkHaQH6ma
         TELHv0rvq2TF4GOKxfmVexwbh7hOsMOvYpHMvc+2pnD4aVoJk5gcFFNbvrmR/EHOYDom
         1LKhRHsB2oidwd+HkG9JUl/7bCDYYrLzpMDEdPTHXrt9rc5gxJ8JNkgMEz+46Je+SgpJ
         K322+b3hhx0xTptu2U4vPvwbelvTQ/AIZmADybpNIQCUTqH6tiWElhkMNxwJ7PyuMmLE
         wWSg==
X-Gm-Message-State: APjAAAUz6zAPoeR6CUE7nUah2MZ0l182h8hQkMeIfy0IPjgoPG79X8lH
        OgWsw1MjU256knQ4mJvW/auoYg==
X-Google-Smtp-Source: APXvYqzTSv6CMEyQM3i6C4SK/hTjeAMaTon8/RvoovUvDlefqH05gxDzk92qF3PTigpHHIEcQwWRyw==
X-Received: by 2002:a05:600c:2481:: with SMTP id 1mr14687975wms.98.1571064280936;
        Mon, 14 Oct 2019 07:44:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id z189sm33273049wmc.25.2019.10.14.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:44:40 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:44:40 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: Module loading problem since 5.3
Message-ID: <20191014144440.GG35313@google.com>
References: <20191014085235.GW16384@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191014085235.GW16384@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis!

On Mon, Oct 14, 2019 at 08:52:35AM +0000, Luis Chamberlain wrote:
>On Fri, Oct 11, 2019 at 09:26:05PM +0200, Heiner Kallweit wrote:
>> On 10.10.2019 19:15, Luis Chamberlain wrote:
>> >
>> >
>> > On Thu, Oct 10, 2019, 6:50 PM Heiner Kallweit <hkallweit1@gmail.com <mailto:hkallweit1@gmail.com>> wrote:
>> >
>> >        MODULE_SOFTDEP("pre: realtek")
>> >
>> >     Are you aware of any current issues with module loading
>> >     that could cause this problem?
>> >
>> >
>> > Nope. But then again I was not aware of MODULE_SOFTDEP(). I'd encourage an extension to lib/kmod.c or something similar which stress tests this. One way that comes to mind to test this is to allow a new tests case which loads two drives which co depend on each other using this macro. That'll surely blow things up fast. That is, the current kmod tests uses request_module() or get_fs_type(), you'd want a new test case with this added using then two new dummy test drivers with the macro dependency.
>> >
>> > If you want to resolve this using a more tested path, you could have request_module() be used as that is currently tested. Perhaps a test patch for that can rule out if it's the macro magic which is the issue.
>> >
>> >   Luis
>>
>> Maybe issue is related to a bug in introduction of symbol namespaces, see here:
>> https://lkml.org/lkml/2019/10/11/659
>
>Can you have your user with issues either revert 8651ec01daed or apply the fixes
>mentioned by Matthias to see if that was the issue?
>
>Matthias what module did you run into which let you run into the issue
>with depmod? I ask as I think it would be wise for us to add a test case
>using lib/test_kmod.c and tools/testing/selftests/kmod/kmod.sh for the
>regression you detected.

The depmod warning can be reproduced when using a symbol that is built
into vmlinux and used from a module. E.g. with CONFIG_USB_STORAGE=y and
CONFIG_USB_UAS=m, the symbol `usb_stor_adjust_quirks` is built in with
namespace USB_STORAGE and depmod stumbles upon this emitting the
following warning (e.g. during make modules_install).

  depmod: WARNING: [...]/uas.ko needs unknown symbol usb_stor_adjust_quirks

As there is another (less intrusive) way of implementing the namespace
feature, I posted a patch series [1] on last Thursday that should
mitigate the issue as the ksymtab entries depmod eventually relies on
are no longer carrying the namespace in their names.

Cheers,
Matthias

[1] https://lore.kernel.org/lkml/20191010151443.7399-1-maennich@google.com/

>
>  Luis
