Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF4AC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FCF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCTI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:29:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:29:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h6WbN-0007Ez-FR; Wed, 20 Mar 2019 09:29:33 +0100
Date:   Wed, 20 Mar 2019 09:29:32 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     lantianyu1986@gmail.com, Lan Tianyu <Tianyu.Lan@microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rkrcmar@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
In-Reply-To: <a379e291-b622-3535-8436-2cf3f3446c74@redhat.com>
Message-ID: <alpine.DEB.2.21.1903200928100.1816@nanos.tec.linutronix.de>
References: <20190222104844.1847-1-Tianyu.Lan@microsoft.com> <a379e291-b622-3535-8436-2cf3f3446c74@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Paolo Bonzini wrote:

> On 22/02/19 11:48, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
> > is equal with how many entries of union hv_gpa_page_range can be populated
> > into the input parameter page. The origin code lacks parenthesis around
> > PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixs: cc4edae4b9(x86/hyper-v: Add HvFlushGuestAddressList hypercall support)
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 705dafc2d11a..2bdbbbcfa393 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -841,7 +841,7 @@ union hv_gpa_page_range {
> >   * count is equal with how many entries of union hv_gpa_page_range can
> >   * be populated into the input parameter page.
> >   */
> > -#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
> > +#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
> >  				sizeof(union hv_gpa_page_range))
> >  
> >  struct hv_guest_mapping_flush_list {
> > 
> 
> Queued for after he merge window, with the fixed "Fixes" tag.

That's upstream already:

  9cd05ad2910b ("x86/hyper-v: Fix definition of HV_MAX_FLUSH_REP_COUNT")

Thanks,

	tglx
