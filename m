Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8EEC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ECD21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfLECI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:08:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35972 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbfLECI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:08:27 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icgZ1-0006BN-7V; Thu, 05 Dec 2019 02:08:20 +0000
Date:   Thu, 5 Dec 2019 02:08:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix cast of gfp_t to ulong in __def_gfpflag_names
Message-ID: <20191205020819.GJ4203@ZenIV.linux.org.uk>
References: <20191204175425.71855-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204175425.71855-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:54:25PM +0100, Luc Van Oostenryck wrote:
> The macro '__def_gfpflag_names' is used to define arrays of
> struct trace_print_flags. This structure is defined as being
> a pair of 'unsigned long' - 'const char *'.
> 
> However, the macro __def_gfpflag_names is used to for GFP flags
> and thus take entries of type gfp_t (plus their name) which
> is a bitwise type, non-convertible to usual integers.
> These entries are casted to 'unsigned long' but this doesn't
> prevent Sparse to rughtfully complain:
> 	warning: cast from restricted gfp_t
> 
> The correct way to cast a bitwise type to a normal integer
> (which is OK here) is to use '__force'.
> 
> So, fix the cast by adding the '__force' required for such casts.

Ugh...
> -	{(unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
<plenty of such>
> +	{(__force ulong)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\

# operator is there for purpose; as in
#define FOO(name) {(__force unsigned long)name, #name}
with those becoming
#define __def_gfpflag_names \
	FOO(GFP_TRANSHUGE), \
	FOO(GFP_TRANSHUGE_LIGHT), \
etc.
