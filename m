Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F6C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E8C206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVhb9QWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfGBQUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:20:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45181 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBQUE (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:20:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so19085561qtr.12
        for <Linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4w/MDBNv3iUQGxjOuXMc7q7bDfdIO0JZ1no+O2HkE5o=;
        b=OVhb9QWsAWEU0vLzcnOpKkeiuD24F5M/j5CTqzytjSMQkyFmO7AqgyLgKl28qmpoji
         2E1LPPeYmgoXMGus13Dmnc83bkVWRnrTD3QLgd6PCOmP+quuAVm6rWREo+/K3o9FgsSC
         qrDYrko6oYzhAFXMT8RxQ7QO5s6FFik58UjUPtvpIxRhnNCz4wu4sUFy5ZAJuKmVizxd
         PKPj92SGeRvR1oluO4YzXh5MzsdoNyN+c3x5DDlKCLy7hHZNv9hh3Bc3fR9+btutZR6k
         pdnlFi351fyEVaur4n1aNtzyjq7RuhLReGdZykalsXAZGcyhyfdyj+Y1fOwxteTXuKEF
         DLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4w/MDBNv3iUQGxjOuXMc7q7bDfdIO0JZ1no+O2HkE5o=;
        b=SuyL+VnfD/4TKb0JZj9S35raFbX5NpiFXhpRJ6C4WB3JL9crnafNeDSkamqf8CBsAC
         f9ZlYyuIrLScf/N/E0hG5Xr8bU3zNVf0AA+8GL7hpCDITfQvu5gDSo2is9SXkM4lQP1A
         eDlTmN0Aaw4AgoSEXQRo4+Dalfg1yKwMNBH5HUu2i2o6UZLOoHbkO89J0rerrUvJ8k8D
         L6he5PMP6F/3aG8KRhyNFqPCF7KTXq1gZq9b3kh0Dh9z13GwbfmD9nWYlVzO7jOgOwoS
         OYtGTRTbI2IWh0xrFJWd4RFzRImMRVlPYAk1H2gZdGim2gwfF55BdgiR6utl0lrY1M9K
         Md8w==
X-Gm-Message-State: APjAAAXUYEEPj0AwLYGyCcAxijkk2S+6u+ZPv0mihMaxjGrFv3P2n9Hc
        DqC2udt4zBnU9QaHQHI0E+Y=
X-Google-Smtp-Source: APXvYqxHpT0aIYXGn6EymplbFh+yhFYQRpEreWTnfzV66baNf8AixVrqu+MPiQWUkVSs6S3r235aUg==
X-Received: by 2002:a0c:9e27:: with SMTP id p39mr27201473qve.151.1562084403551;
        Tue, 02 Jul 2019 09:20:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o17sm6091011qkm.6.2019.07.02.09.20.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:20:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7407E41153; Tue,  2 Jul 2019 13:20:00 -0300 (-03)
Date:   Tue, 2 Jul 2019 13:20:00 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 5/7] perf diff: Link same basic blocks among different
 data
Message-ID: <20190702162000.GL15462@kernel.org>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
 <1561713784-30533-6-git-send-email-yao.jin@linux.intel.com>
 <20190702161739.GK15462@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702161739.GK15462@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 01:17:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jun 28, 2019 at 05:23:02PM +0800, Jin Yao escreveu:
> > The target is to compare the performance difference (cycles
> > diff) for the same basic blocks in different data files.
> > 
> > The same basic block means same function, same start address
> > and same end address. This patch finds the same basic blocks
> > from different data files and link them together and resort
> > by the cycles diff.
> > 
> >  v3:
> >  ---
> >  The block stuffs are maintained by new structure 'block_hist',
> >  so this patch is update accordingly.
> > 
> >  v2:
> >  ---
> >  Since now the basic block hists is changed to per symbol,
> >  the patch only links the basic block hists for the same
> >  symbol in different data files.
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > ---
> >  tools/perf/builtin-diff.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> > index 83b8c0f..823f162 100644
> > --- a/tools/perf/builtin-diff.c
> > +++ b/tools/perf/builtin-diff.c
> > @@ -641,6 +641,85 @@ static int process_block_per_sym(struct hist_entry *he)
> >  	return 0;
> >  }
> >  
> > +static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
> > +{
> > +	struct block_info *bi_a = a->block_info;
> > +	struct block_info *bi_b = b->block_info;
> > +	int cmp;
> > +
> > +	if (!bi_a->sym || !bi_b->sym)
> > +		return -1;
> > +
> > +	if (bi_a->sym->name && bi_b->sym->name) {
> > +		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> > +		if ((!cmp) && (bi_a->start == bi_b->start) &&
> > +		    (bi_a->end == bi_b->end)) {
> > +			return 0;
> > +		}
> 
> 
> builtin-diff.c:658:17: error: address of array 'bi_a->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>         if (bi_a->sym->name && bi_b->sym->name) {
>             ~~~~~~~~~~~^~~~ ~~
> builtin-diff.c:658:36: error: address of array 'bi_b->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>         if (bi_a->sym->name && bi_b->sym->name) {
> 
> Because:
> 
> struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
> {
>         size_t namelen = strlen(name) + 1;
>         struct symbol *sym = calloc(1, (symbol_conf.priv_size +
>                                         sizeof(*sym) + namelen));
> 
> 
> So it will be at least a strlen(sym->name) == 0, i.e. we can use it
> without checking anything.
> 
> I'm chanign it to do the cmp straight away

i.e. I added this on top of this patch:


diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 823f162b0060..fafb7b3f58fb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -650,13 +650,10 @@ static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
 	if (!bi_a->sym || !bi_b->sym)
 		return -1;
 
-	if (bi_a->sym->name && bi_b->sym->name) {
-		cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
-		if ((!cmp) && (bi_a->start == bi_b->start) &&
-		    (bi_a->end == bi_b->end)) {
-			return 0;
-		}
-	}
+	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
+
+	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
+		return 0;
 
 	return -1;
 }
