Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3907BC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102112081E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgAHB7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAHB7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:59:50 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF902075A;
        Wed,  8 Jan 2020 01:59:47 +0000 (UTC)
Date:   Tue, 7 Jan 2020 20:59:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/22] bootconfig: Add Extra Boot Config support
Message-ID: <20200107205945.63e5d35a@rorschach.local.home>
In-Reply-To: <157736904075.11126.16068256892686522924.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
 <157736904075.11126.16068256892686522924.stgit@devnote2>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2019 23:04:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> +/**
> + * xbc_node_is_value() - Test the node is a value node
> + * @node: An XBC node.
> + *
> + * Test the @node is a value node and return true if a value node, false if not.
> + */
> +static inline __init bool xbc_node_is_value(struct xbc_node *node)
> +{
> +	return !!(node->data & XBC_VALUE);

The "!!" is not needed, as this is a static inline bool function. The
compiler will make this a 1 or 0 without it.

	return node->data & XBC_VALUE;

is sufficient.

> +}
> +
> +/**
> + * xbc_node_is_key() - Test the node is a key node
> + * @node: An XBC node.
> + *
> + * Test the @node is a key node and return true if a key node, false if not.
> + */
> +static inline __init bool xbc_node_is_key(struct xbc_node *node)
> +{
> +	return !(node->data & XBC_VALUE);
> +}
> +



> +
> +/*
> + * Return delimiter or error, no node added. As same as lib/cmdline.c,
> + * you can use " around spaces, but can't escape " for value.
> + */
> +static int __init __xbc_parse_value(char **__v, char **__n)
> +{
> +	char *p, *v = *__v;
> +	int c, quotes = 0;
> +
> +	v = skip_spaces(v);
> +	while (*v == '#') {
> +		v = skip_comment(v);
> +		v = skip_spaces(v);
> +	}
> +	if (*v == '"' || *v == '\'') {
> +		quotes = *v;
> +		v++;
> +	}
> +	p = v - 1;
> +	while ((c = *++p)) {
> +		if (!isprint(c) && !isspace(c))
> +			return xbc_parse_error("Non printable value", p);
> +		if (quotes) {
> +			if (c != quotes)
> +				continue;
> +			quotes = 0;
> +			*p++ = '\0';
> +			p = skip_spaces(p);

Hmm, if p here == "    \0" then skip_spaces() will make p == "\0"

> +			c = *p;
> +			if (c && !strchr(",;\n#}", c))
> +				return xbc_parse_error("No value delimiter", p);
> +			p++;

Now p == one passed "\0" which is in unknown territory.

> +			break;
> +		}
> +		if (strchr(",;\n#}", c)) {

Also, why are we looking at '\n'? as wouldn't that get skipped by
skip_spaces() too?

-- Steve

> +			v = strim(v);
> +			*p++ = '\0';
> +			break;
> +		}
> +	}
> +	if (quotes)
> +		return xbc_parse_error("No closing quotes", p);
> +	if (c == '#') {
> +		p = skip_comment(p);
> +		c = *p;
> +	}
> +	*__n = p;
> +	*__v = v;
> +
> +	return c;
> +}
> +
