Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E68C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC3C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfCHT3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:29:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCHT3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:29:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B91353082B1E;
        Fri,  8 Mar 2019 19:29:51 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49D455D787;
        Fri,  8 Mar 2019 19:29:48 +0000 (UTC)
Date:   Fri, 8 Mar 2019 13:29:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 14/20] objtool: Rewrite add_ignores()
Message-ID: <20190308192945.345bw2ut7bsd5ckl@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.330826767@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307115200.330826767@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 08 Mar 2019 19:29:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:25PM +0100, Peter Zijlstra wrote:
> @@ -436,18 +413,31 @@ static void add_ignores(struct objtool_f
>  	struct instruction *insn;
>  	struct section *sec;
>  	struct symbol *func;
> +	struct rela *rela;
>  
> -	for_each_sec(file, sec) {
> -		list_for_each_entry(func, &sec->symbol_list, list) {
> -			if (func->type != STT_FUNC)
> -				continue;
> +	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
> +	if (!sec)
> +		return;
>  
> -			if (!ignore_func(file, func))
> +	list_for_each_entry(rela, &sec->rela_list, list) {
> +		switch (rela->sym->type) {
> +		case STT_FUNC:
> +			func = rela->sym;
> +			break;
> +
> +		case STT_SECTION:
> +			func = find_symbol_by_offset(rela->sym->sec, rela->addend);
> +			if (!func || func->type != STT_FUNC)
>  				continue;
> +			break;
>  
> -			func_for_each_insn_all(file, func, insn)
> -				insn->ignore = true;
> +		default:
> +			WARN("unexpected relation symbol type in %s: %d", sec->name, rela->sym->type);
> +			continue;

s/relation/relocation

-- 
Josh
