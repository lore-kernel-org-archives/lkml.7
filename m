Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B21C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463CB2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHGA3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:29:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36669 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727617AbfHGA3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:29:32 -0400
X-UUID: 8b691bcbe4874fa9937b0efe4dee114f-20190807
X-UUID: 8b691bcbe4874fa9937b0efe4dee114f-20190807
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1562935432; Wed, 07 Aug 2019 08:29:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 7 Aug 2019 08:29:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 7 Aug 2019 08:29:21 +0800
Message-ID: <1565137761.18034.1.camel@mtkswgap22>
Subject: Re: [PATCH] arm64: mm: print hexadecimal EC value in
 mem_abort_decode()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morse <james.morse@arm.com>
Date:   Wed, 7 Aug 2019 08:29:21 +0800
In-Reply-To: <20190806123450.GE475@lakrids.cambridge.arm.com>
References: <20190806112948.4357-1-miles.chen@mediatek.com>
         <20190806123450.GE475@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 13:34 +0100, Mark Rutland wrote:
> On Tue, Aug 06, 2019 at 07:29:48PM +0800, Miles Chen wrote:
> > This change prints the hexadecimal EC value in mem_abort_decode(),
> > which makes it easier to lookup the corresponding EC in
> > the ARM Architecture Reference Manual.
> > 
> > The commit 1f9b8936f36f ("arm64: Decode information from ESR upon mem
> > faults") prints useful information when memory abort occurs. It would
> > be easier to lookup "0x25" instead of "DABT" in the document. Then we
> > can check the corresponding ISS.
> > 
> > For example:
> > Current	info	  	Document
> > 		  	EC	Exception class
> > "CP15 MCR/MRC"		0x3	"MCR or MRC access to CP15a..."
> > "ASIMD"			0x7	"Access to SIMD or floating-point..."
> > "DABT (current EL)" 	0x25	"Data Abort taken without..."
> > ...
> > 
> > Before:
> > Unable to handle kernel paging request at virtual address 000000000000c000
> > Mem abort info:
> >   ESR = 0x96000046
> >   Exception class = DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> > Data abort info:
> >   ISV = 0, ISS = 0x00000046
> >   CM = 0, WnR = 1
> > 
> > After:
> > Unable to handle kernel paging request at virtual address 000000000000c000
> > Mem abort info:
> >   ESR = 0x96000046
> >   EC = 0x25, Exception class = DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> > Data abort info:
> >   ISV = 0, ISS = 0x00000046
> >   CM = 0, WnR = 1
> > 
> > Cc: Mark Rutland <Mark.rutland@arm.com>
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > ---
> >  arch/arm64/mm/fault.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index cfd65b63f36f..afb6041e25e6 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -86,8 +86,8 @@ static void mem_abort_decode(unsigned int esr)
> >  	pr_alert("Mem abort info:\n");
> >  
> >  	pr_alert("  ESR = 0x%08x\n", esr);
> > -	pr_alert("  Exception class = %s, IL = %u bits\n",
> > -		 esr_get_class_string(esr),
> > +	pr_alert("  EC = 0x%lx, Exception class = %s, IL = %u bits\n",
> > +		 ESR_ELx_EC(esr), esr_get_class_string(esr),
> 
> Could we make this:
> 
> 	pr_alert("  EC = 0x%02lx: %s, IL = %u bits\n",
> 		 ESR_ELx_EC(esr), esr_get_class_string(esr));
> 
> We don't need to spell out "Exception Class" if we say "EC", and we
> should print the EC hex value with a consistent width as we do for the
> ISS.

Thanks for the advise.
It looks better this way. I'll send patch v2.



Miles

> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.


