Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C020449
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvV/cf2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfGaOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:20:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39620 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGaOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:20:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so47542558lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tqyiJ7/XxY9wcDcHIhHFdYW9QSR1ytZewDz36bdtEeQ=;
        b=CvV/cf2B2FlWyJRjSrDP0ysoQFlxUTIPgK6ifpFoyykJNg4pnlJX5yE+8ygr+0fFk8
         Q+pXmysgOZS3DGJeJoDDsdmNmlYhYk5YDQ+XerJ+I40K4QdliyLBdBf1sAcO/THKeZ+z
         VyzS+Rq75SKSc8Myg74gx27BzyHIcOQpvDjp2vTJT95a/QDfTb5gGqSkZ2dc8lVkMIW8
         QmJmrxhr+w4MdhOw/vb6a3nyIp2NlnzIEpvNG3AVGuzEJbc79i9Q9/f0re82nNXJyxLL
         drt52sb712yzli937K0tM34jFVxIRgDpEfraKM5p7orUxSy/Kc40r0VGCsmPRTbTew/N
         vVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tqyiJ7/XxY9wcDcHIhHFdYW9QSR1ytZewDz36bdtEeQ=;
        b=IXCxcF3rhCuI5ftLriCxqDRIfVEND/G8Lrv0p/eC2q20lMShdpC0hnGQ3QuMMN68mp
         mh54bStr8unMbj+ox5jSMcLwwEd7TZYo0SWDgbH4lSjmGYXszuAmQN+kKqsojkgi9HNs
         1R/dmQA+pj1our+C1EESzZIZXNjuGMf4IXZpEjdWz1W8H/+Ei93qE/qqLuq8nwCgurtg
         rX5KlCh3H5nzlIjxNaLFVMTSPvjBO+XfdIR5U8U1GWIAWThKWWkAcUoyLL6LyNB4P23z
         nbGGvweihuzqfbz3QRWMOPPhfKGix42/rTJognR9VYNnDZKK0yzBSc91A88xZPPcxVeT
         L+ew==
X-Gm-Message-State: APjAAAUGB52kcUTE25ivuxoLs5C+HlfYcnF3yh9AblUKtMUGqtstxFHA
        4Wn2ftNzjRK1z04DKopx+7w=
X-Google-Smtp-Source: APXvYqw8pxpX+1VJJTbfSInV/uZt35wYuJ4r1FHPSAS8YdXRLp6p9QTZTqIF0+RB5Mo+se59be/v+Q==
X-Received: by 2002:a19:f819:: with SMTP id a25mr60961319lff.183.1564582824856;
        Wed, 31 Jul 2019 07:20:24 -0700 (PDT)
Received: from pc636 ([37.212.202.204])
        by smtp.gmail.com with ESMTPSA id v22sm11896102lfe.49.2019.07.31.07.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 07:20:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 31 Jul 2019 16:20:11 +0200
To:     Michel Lespinasse <walken@google.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190731140948.xtuwtfsjth5ecgo3@pc636>
References: <20190703040156.56953-1-walken@google.com>
 <20190703040156.56953-3-walken@google.com>
 <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
 <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
 <20190729101454.jd6ej2nrlyigjqs4@pc636>
 <CANN689FMTh=Odn-KM06bPAf9zFwOpSg3FthL7Q5OXRGVWQUOhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FMTh=Odn-KM06bPAf9zFwOpSg3FthL7Q5OXRGVWQUOhg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michel.

> 
> Hmmm, I had not thought about that. Agree that this can be useful -
> there is already similar test code in rbtree_test.c and also
> vma_compute_subtree_gap() in mmap.c, ...
> 
> With patch 3/3 of this series, the RBCOMPUTE function (typically
> generated through the RB_DECLARE_CALLBACKS_MAX macro) will return a
> bool indicating if the node's augmented value was already correctly
> set. Maybe this can be used for test code, through in the false case,
> the node's augmented value is already overwritten with the correct
> value. Not sure if that is a problem though - the files I mentioned
> above have test code that will dump the values if there is a mismatch,
> but really I think in every realistic case just noting that there was
> one would be just as helpful as being able to dump the old (incorrect)
> value....
> 
> What do you think - is the RBCOMPUTE(node, true) function sufficient
> for such debugging ?
>
I think so, at least i do not see any issues with that. If it returns
"false" then it will indicate that the node was not correctly augmented.

Also, i see in many places across your patches there is below code:

<snip>
	RBSTRUCT *child;						      \
	RBTYPE max = RBCOMPUTE(node);					      \
	if (node->RBFIELD.rb_left) {					      \
		child = rb_entry(node->RBFIELD.rb_left, RBSTRUCT, RBFIELD);   \
		if (child->RBAUGMENTED > max)				      \
			max = child->RBAUGMENTED;			      \
	}								      \
	if (node->RBFIELD.rb_right) {					      \
		child = rb_entry(node->RBFIELD.rb_right, RBSTRUCT, RBFIELD);  \
		if (child->RBAUGMENTED > max)				      \
			max = child->RBAUGMENTED;			      \
	}								      \
	if (exit && node->RBAUGMENTED == max)				      \
		return true;						      \
	node->RBAUGMENTED = max;					      \
	return false;
<snip>

i think it can be simplified by using max3 macro. For example:

<snip>
get_subtree_max(struct rb_node *node)
{
	struct something *foo;

	va = rb_entry_safe(node, struct something, rb_node);
	return foo ? foo->subtree_max : 0;
}

compute_subtree_max_size(struct vmap_area *va)
{
	return max3(va_size(va),
		get_subtree_max_size(va->rb_node.rb_left),
		get_subtree_max_size(va->rb_node.rb_right));
}
<snip>

What do you think about that?

Thank you.

--
Vlad Rezki
