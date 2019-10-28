Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7680CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59872054F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 23:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGUuw+M4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfJ1XDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 19:03:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52654 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfJ1XDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:03:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so656419wmg.2;
        Mon, 28 Oct 2019 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6kOh9lI6YWchLWC+l1b8QT9L947fcvZOAFfSe858fBU=;
        b=qGUuw+M4JqKVUXl04qUvKcdPECeB8d1xsX6pthiAeWmiu0awZf0ZHOn0LnqLAHqflx
         T7fjj1NjVbBBi1BfufVzE/0m/IeVOZaOmMnarD5gYLGm4MLbjHI5nDWYWu+jYF/UaX7I
         YaUx2bk8uhI1ULCgamNeJw87EmeoA6T01mh3WI7MTOMe6bdVR+WuwCNDPnh7n6701H5X
         hZ6xbUKgzb4JVXdcQ1jxlGIEKMCwgiJH3e9Ii1i4ME6wVlQ2AEqVUprQIcDBqsk2tgE2
         QytMHotDaAjBcDOmkxGwJdEQTXy4HF+GypoHZZo6df7z6mD+JY/rrtTD9dOb5f8PnYuF
         QVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6kOh9lI6YWchLWC+l1b8QT9L947fcvZOAFfSe858fBU=;
        b=V1JVIZdD+9uf0jZYudfC0n4Ahxu2Dluu4VdcNc9ntm/hbD0y91ABZt00RxRML4zt0S
         3U5q6Da0LqtqlJZfA6bRcWcOcM8ZZNVnTthXa57gshe5xzmaBBoxQ9Mt3VaXpduOZCBE
         l4XYFM2V93fALXrMlL2Wtw30J+TGCbLTJRkrUsgEFKnn+HlV9/KytaOFQSXI28w2Q+3J
         1UsvilhbmP5/Qs0itx/gCvwfssaE4lOXxTECQOGZWqftLo7jMbwmo4XFLe3gSQqxPiAX
         TtcqMXZaHmV1z48oPezKgcP7yBd6p3QnYLY1PNpytM69F7W2saUqLhaIGtLcKKpruNI7
         9ysA==
X-Gm-Message-State: APjAAAVcMrbSoR3h+tprSRRmmnjALWTm2SdDrmie+2PKtOH+MBGV5fZk
        YR9QmeqSEYvelpjqAZ7JbGw=
X-Google-Smtp-Source: APXvYqy9JjpFZLPex5bjiSgGuPxUvDWHyonMNNuURSf9tE4joKsbDU/UXy0WjRz6J2/2J19GfmhEFA==
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr1382807wmc.117.1572303831985;
        Mon, 28 Oct 2019 16:03:51 -0700 (PDT)
Received: from desk.local ([2a02:a03f:40ac:ce00:6dcd:e18f:2cd1:7611])
        by smtp.gmail.com with ESMTPSA id l4sm14504010wrf.46.2019.10.28.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 16:03:51 -0700 (PDT)
Date:   Tue, 29 Oct 2019 00:03:50 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Message-ID: <20191028230349.xlhm42ripxktx43y@desk.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
 <20191028221523.vlzdk6dkcglxei6v@desk.local>
 <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 03:28:17PM -0700, Joe Perches wrote:
> On Mon, 2019-10-28 at 23:15 +0100, Luc Van Oostenryck wrote:
> > On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
> > > On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> > > > Just in case: for these ones (i.e. __CHECKER__), did you check if
> > > > sparse handles this syntax? (I don't recall myself if it does).
> > > > 
> > > > Other than that, thanks for the cleanup too! I can pick it up in the
> > > > the compiler-attributes tree and put it in -next.
> > > 
> > > Thanks for asking and no, I did  not until just now.
> > > Turns out sparse does _not_ handle these changes and
> > > the checking fails for these __<changes>__.
> > > 
> > > sparse would have to update parse.c or the __CHECKER__
> > > changes would need to be reverted.
> > > 
> > > Perhaps update parse.c like:
> > 
> > ...
> > 
> > Yes, this was missing. Thanks.
> > Can I have your SoB for this?
> 
> I'm not sure this actually works as there's
> some possible sparse parsing changes in the
> use of __context__.

Yes, indeed. The following shoud be squashed on top of
your patch (not tested yet on linux side):

-- Luc

diff --git a/parse.c b/parse.c
index 4464e2667..4b0a1566c 100644
--- a/parse.c
+++ b/parse.c
@@ -345,6 +345,7 @@ static struct symbol_op goto_op = {
 
 static struct symbol_op __context___op = {
 	.statement = parse_context_statement,
+	.attribute = attribute_context,
 };
 
 static struct symbol_op range_op = {
@@ -537,6 +538,7 @@ static struct init_keyword {
 	{ "while",	NS_KEYWORD, .op = &while_op },
 	{ "do",		NS_KEYWORD, .op = &do_op },
 	{ "goto",	NS_KEYWORD, .op = &goto_op },
+	{ "context",	NS_KEYWORD, .op = &context_op },
 	{ "__context__",NS_KEYWORD, .op = &__context___op },
 	{ "__range__",	NS_KEYWORD, .op = &range_op },
 	{ "asm",	NS_KEYWORD, .op = &asm_op },
@@ -560,8 +562,6 @@ static struct init_keyword {
 	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "__address_space__",NS_KEYWORD,	.op = &address_space_op },
-	{ "context",	NS_KEYWORD,	.op = &context_op },
-	{ "__context__",NS_KEYWORD,	.op = &context_op },
 	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "__designated_init__",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "transparent_union",	NS_KEYWORD,	.op = &transparent_union_op },
