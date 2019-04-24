Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7722F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfDXQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:23:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfDXQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4702F30C45BC;
        Wed, 24 Apr 2019 16:23:27 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 678A7600C1;
        Wed, 24 Apr 2019 16:23:26 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:23:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 2/6] objtool: arm64: Add required implementation for
 supporting the aarch64 architecture in objtool.
Message-ID: <20190424162324.36xn7aepuggyvbzi@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-3-raphael.gault@arm.com>
 <20190423201823.fnddnyxpu64jnlgp@treble>
 <fe8a45e3-dfb1-84fc-8912-9cff257e6f1f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe8a45e3-dfb1-84fc-8912-9cff257e6f1f@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Apr 2019 16:23:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:16:26PM +0000, Raphael Gault wrote:
> On 4/23/19 9:18 PM, Josh Poimboeuf wrote:
> > On Tue, Apr 09, 2019 at 02:52:39PM +0100, Raphael Gault wrote:
> >> Provide implementation for the arch-dependent functions that are called by the main check
> >> function of objtool.
> >> The ORC unwinder is not yet supported by the arm64 architecture so we only provide a dummy
> >> interface for now.
> >> The decoding of the instruction is split into classes and subclasses as described into
> >> the Instruction Encoding in the ArmV8.5 Architecture Reference Manual.
> >
> > Where did the code for the decoder come from?  Was it written from
> > scratch?
> >
> 
> This decoder was indeed written from scratch based on the armv8 ARM. The
> automatic generation idea hasn't really been discussed yet.

Ok.  That's a lot of code.  Hopefully ARM folks can review it closely.

> >> +#ifndef __ASSEMBLY__
> >> +/*
> >> + * This struct is more or less a vastly simplified version of the DWARF Call
> >> + * Frame Information standard.  It contains only the necessary parts of DWARF
> >> + * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
> >> + * unwinder how to find the previous SP and BP (and sometimes entry regs) on
> >> + * the stack for a given code address.  Each instance of the struct corresponds
> >> + * to one or more code locations.
> >> + */
> >> +struct orc_entry {
> >> +s16sp_offset;
> >> +s16bp_offset;
> >> +unsignedsp_reg:4;
> >> +unsignedbp_reg:4;
> >> +unsignedtype:2;
> >> +unsignedend:1;
> >> +} __packed;
> >> +
> >> +/*
> >> + * This struct is used by asm and inline asm code to manually annotate the
> >> + * location of registers on the stack for the ORC unwinder.
> >> + *
> >> + * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
> >> + */
> >> +struct unwind_hint {
> >> +u32ip;
> >> +s16sp_offset;
> >> +u8sp_reg;
> >> +u8type;
> >> +u8end;
> >> +};
> >> +#endif /* __ASSEMBLY__ */
> >> +
> >> +#endif /* _ORC_TYPES_H */
> >
> > It seems odd to have the above header file in arm64 code, since it
> > doesn't implement ORC.  Is it really needed?
> >
> 
> The unwind_hint part can safely be removed. However the orc_entry seems
> to be needed since the struct instruction comports a struct orc_entry
> field. I have chosen to let it here as well but maybe a better approach
> is possible.

Ideally we can figure out a way to decouple 'struct instruction' from
'struct orc_entry'.  But yes, I think your approach is fine for now.

Though I think using an arch-independent header file would be better, to
avoid creating duplicated (dead) code.

-- 
Josh
