Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270EAC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F9B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJ3IGV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:06:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40384 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJ3IGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:06:20 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iPizi-0008DX-8P
        for linux-kernel@vger.kernel.org; Wed, 30 Oct 2019 08:06:18 +0000
Received: by mail-pg1-f199.google.com with SMTP id v10so1035747pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 01:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L0tOiWIydj5CKljWNZmAK+aAA1mTh46IOLFAvkfBMjs=;
        b=Jft6bty2MUXJv6nSLmGCiN3aGlHnysgbp9BtCKNkNY1682tF0HiaRSpAKi+76Fw8xr
         PnPt7vuFaXgEtREArAaEAv7v5m9/pxwsvAnyAfHvthKIYRfVryTxZpwes8poIsUWgnlF
         +FcIlu7qrPczOGNUC6WDO0kdLTgF0X5PDsd+dk/DQFL7QTMJfJXUlexGRMQH5dejCMEn
         29MNex8QZA8e3Lj/1Nzzk2yFGFcnFF9QQ5PjEJ42Z+ATUchP8cUopIJbeVFlFfysogKy
         9RMrrq/vBLuipkL4OSgiZu/DfPGlKwvQDyupwz8SJj+E9n1pgH5dGgv+JxYiBnJTy0c4
         brGA==
X-Gm-Message-State: APjAAAXYl+8HdwpDasHTPWxcGyloBmJ8covM3qvu+9hEw8OnAk3vh65x
        ywyvjewUmhFvcv624eEDrx0LvodAUXquIf4lFcJUhoOU4OkCP6fCUuDR7lf1Y9eXLkhHuL8XoVH
        dKFkmSRQInrj/jrtKQUOBfTQijN9evE41s1dFBcteTw==
X-Received: by 2002:a65:588e:: with SMTP id d14mr30104936pgu.56.1572422776861;
        Wed, 30 Oct 2019 01:06:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjqeW/O9+0sJrDZkNWl5XuojZ9KLMO5fRYWvaW19tO/ikhUNfKG+QPqQ2zG4XhPzCTUlry1Q==
X-Received: by 2002:a65:588e:: with SMTP id d14mr30104908pgu.56.1572422776541;
        Wed, 30 Oct 2019 01:06:16 -0700 (PDT)
Received: from 2001-b011-380f-3c42-507c-6d05-b0b1-d40f.dynamic-ip6.hinet.net (2001-b011-380f-3c42-507c-6d05-b0b1-d40f.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:507c:6d05:b0b1:d40f])
        by smtp.gmail.com with ESMTPSA id q7sm1739666pff.19.2019.10.30.01.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 01:06:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH] x86/intel: Disable HPET on Intel Coffe Lake platforms
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191016103816.30650-1-kai.heng.feng@canonical.com>
Date:   Wed, 30 Oct 2019 16:06:13 +0800
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Harry Pan <harry.pan@intel.com>,
        feng.tang@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9CFF6CF0-9053-4206-B2C3-D286019B785F@canonical.com>
References: <20191016103816.30650-1-kai.heng.feng@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> On Oct 16, 2019, at 18:38, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
> PC10, and marked TSC as unstable clocksource as result.
> 
> Harry Pan identified it's a firmware bug [1].
> 
> To prevent creating a circular dependency between HPET and TSC, let's
> disable HPET on affected platforms.
> 
> [1]: https://lore.kernel.org/lkml/20190516090651.1396-1-harry.pan@intel.com/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203183

Do you think it's a sane approach?

Kai-Heng

> 
> Cc: <stable@vger.kernel.org>
> Suggested-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> arch/x86/kernel/early-quirks.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 6f6b1d04dadf..4cba91ec8049 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -710,6 +710,8 @@ static struct chipset early_qrk[] __initdata = {
> 	 */
> 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
> 		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
> +	{ PCI_VENDOR_ID_INTEL, 0x3ec4,
> +		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
> 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
> 	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
> 	{}
> -- 
> 2.17.1
> 

