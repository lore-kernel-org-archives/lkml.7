Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9B0C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 19:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF9A20838
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGFT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 15:28:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59086 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 15:28:58 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjqMf-0002wo-4P; Sat, 06 Jul 2019 19:28:53 +0000
Date:   Sat, 6 Jul 2019 20:28:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 06/12] S.A.R.A.: WX protection
Message-ID: <20190706192852.GO17978@ZenIV.linux.org.uk>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 12:54:47PM +0200, Salvatore Mesoraca wrote:

> +#define sara_warn_or_return(err, msg) do {		\
> +	if ((sara_wxp_flags & SARA_WXP_VERBOSE))	\
> +		pr_wxp(msg);				\
> +	if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))	\
> +		return -err;				\
> +} while (0)
> +
> +#define sara_warn_or_goto(label, msg) do {		\
> +	if ((sara_wxp_flags & SARA_WXP_VERBOSE))	\
> +		pr_wxp(msg);				\
> +	if (!(sara_wxp_flags & SARA_WXP_COMPLAIN))	\
> +		goto label;				\
> +} while (0)

No.  This kind of "style" has no place in the kernel.

Don't hide control flow.  It's nasty enough to reviewers,
but it's pure hell on anyone who strays into your code while
chasing a bug or doing general code audit.  In effect, you
are creating your oh-so-private C dialect and assuming that
everyone who ever looks at your code will start with learning
that *AND* incorporating it into their mental C parser.
I'm sorry, but you are not that important.

If it looks like a function call, a casual reader will assume
that this is exactly what it is.  And when one is scanning
through a function (e.g. to tell if handling of some kind
of refcounts is correct, with twentieth grep through the
tree having brought something in your code into the view),
the last thing one wants is to switch between the area-specific
C dialects.  Simply because looking at yours is sandwiched
between digging through some crap in drivers/target/ and that
weird thing in kernel/tracing/, hopefully staying limited
to 20 seconds of glancing through several functions in your
code.

Don't Do That.  Really.
