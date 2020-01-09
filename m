Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C80C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345F22067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 02:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJuCns1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgAICXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 21:23:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38564 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAICXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 21:23:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so4588319oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 18:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpKaB37AOhauoPCsPH8bCGxpP6t6MKruJ0CgWLMvrAQ=;
        b=eJuCns1dXxBhRe1TlIMfPzPKNzHTMfprez4L1XuLDNKaTvgwktSOZtLd9ECSFDVMWJ
         6YJiyTT5//7FJfppJyPR8URJDhZ7/oJecMDnrt7OraKYbdSek5ZWsjmLI3fC3zEVDpc4
         VxLXsFULGwn+yMCS60UNZsWdNUFJ+Y1Xl0/wYY8/YjZfJ2xysocjML6rtpH485bTlvHW
         xyfkOKkP2sDZurOG6An86U7m/E9Zj+XL40lz2YrjEoH15IkM5502qzJkjcGAXnFdXku+
         kaQNhnFWCIAueDv2LdxPd9iCrg8Pivakfc0bTpzWQ79rR3yroEQmCubGCK1Denn8ScYC
         Br1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpKaB37AOhauoPCsPH8bCGxpP6t6MKruJ0CgWLMvrAQ=;
        b=p6IYsZLtKHIf2qF0TxyWJf9kiqE+3haeUCHaoGXJ3rBPTLzBvRJj3J9lOfxkqSCP5S
         Hm23eUE0Gk0tRcZ8lBlAcEm6eJJVpz04PEBmD4kqKeg5va8QMnGuuFm2lTq2cYMBtnFz
         pSOKUtJbh9tfINRnGXyy15N6wCJHpNWBBLbJi+QXPKyOjmFZbI+JcaN+/Lyp1lGEBqFR
         7oi2bNjSv5/OiFX+ZRubUBuvnIXo7PN011aciN4B7RA9V9e23M0xcNz7DorGaBOagf2W
         LvfF5hzDcNHybPkz/g0ndWyM8Qxv3TlMCHNyUbWtaxr3zgvqjJp0sOuybd5r6S+PJ4ir
         Mdow==
X-Gm-Message-State: APjAAAV6y7rd3Kx+4aubDKd5qBpv0kACOZT72o0Zfp56d3cuJjGAPO/H
        U1viFknwIqQX3carBMJgoPvvHssFDJe4oGaf+1vWEQ==
X-Google-Smtp-Source: APXvYqyrjfLuM3Ikl0VFoqq+4wnh7pbPU3Lx3LyfVTtVIDSYzNAFc6LUwH5lVk6ZGkPQiEswGf9zja02f8W2MC6dPrY=
X-Received: by 2002:a54:4f8d:: with SMTP id g13mr1337770oiy.43.1578536627730;
 Wed, 08 Jan 2020 18:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191224044146.232713-1-saravanak@google.com> <201912252258.5LQtnCYg%lkp@intel.com>
In-Reply-To: <201912252258.5LQtnCYg%lkp@intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Jan 2020 18:23:11 -0800
Message-ID: <CAGETcx90nkOQXgKWtTSg7SRZCTmH9RQijYsZLP6CWpHCmW1Mxw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 6:46 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Saravana,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on efi/next]
> [cannot apply to rockchip/for-next keystone/next arm64/for-next/core arm-soc/for-next shawnguo/for-next clk/clk-next arm/for-next linux-rpi/for-rpi-next at91/at91-next v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Saravana-Kannan/efi-arm-defer-probe-of-PCIe-backed-efifb-on-DT-systems/20191225-182253
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> config: arm64-alldefconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/firmware/efi/arm-init.o: In function `efifb_add_links':
> >> arm-init.c:(.text+0x64): undefined reference to `of_pci_range_parser_init'
>    arm-init.c:(.text+0x64): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_init'
> >> arm-init.c:(.text+0x78): undefined reference to `of_pci_range_parser_one'
>    arm-init.c:(.text+0x78): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `of_pci_range_parser_one'

Ard,

Not sure what's going on here. of_pci_range_parser_init() and
of_pci_range_parser_one() has a stub if CONFIG_OF_ADDRESS isn't
defined. So not sure why the bot is reporting "undefined symbol".
Thoughts?

Also, thoughts on my patch?

-Saravana
