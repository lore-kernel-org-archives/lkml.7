Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D6C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ED12082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1TA4wFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGBQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:00:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37056 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:00:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so14533317qkl.4;
        Tue, 02 Jul 2019 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2hgUHvwb0DoWEwpCAaejVqJUmuPpVeW1cY9iTNfBeJw=;
        b=p1TA4wFigfJ+pPZe7M2eTsp79OgzdHP5n/YeExi1G5CdW1MTYiKYdG+vs7c6x3rVya
         riGn/5SihZ5/ln2BXCfn0sUx9nwS2eTW/+MZ+EVFY13eKpNZHYgyiGn1cLz16pqdgzR8
         6vh00DFIYiK9eHUszzVSSbZfpZ6KyjziELCPR7mIqJENs+O8+YowUvi6GjWtIrq1tPQE
         WPbhynRUV7X4/JzAxImlSR7PN1gebxS91HzQylmrtFypTPhYWjXjOG9vHE00a2Let9Pq
         HOtk6YO6POv/Q1rb6t5oSyeZ+Sq4OqrkGoYZdu4otg4DqSDUPXMgronPR3acl7fJPixp
         D4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2hgUHvwb0DoWEwpCAaejVqJUmuPpVeW1cY9iTNfBeJw=;
        b=B4S+P4yhlRWUW8bNKBLTqeCeeJ9hmQSLz3piPAzP0aSs+TDvEx33onErr4zpmzjadD
         OD/tckQluAnWQoSCoppUAvpz41iVCxRMsAp8dx8p1QDz1VMBfcUE5Kzo/MWXGnZXK/o3
         V4/IA/DfXEP03IOV0DdXq9Gp/3S2XEb8yd7i0WrobhL8PCqCOSQQwhg/5dCEwDs3pdig
         CRVmD+O//jgP4nj3a63IAh5H4PEVEtPD2WKvDbL4R8fvOzxwmKhIjQWCf2RWhEu+2zX1
         TtoGnmHSkhqE4WAlNwiIrt1vA57YEUGq/ZB68nicWdFIWqYwRbkO0xwWZBuXJq/leeS0
         E4+A==
X-Gm-Message-State: APjAAAXn9vmpwN/HbfleQZvxf3OX+RpaqSgOnrQxTO2zU97iZiydLs0+
        HwlZJMNjpriBO2nD5+kuZDY=
X-Google-Smtp-Source: APXvYqyv5uE4SAHTG1h5BZG+SqmqR0Os+GBVVWKhrL9z5HBoZl4T8AzuhPh1iYFNhH63UURx+Ry+Fw==
X-Received: by 2002:a37:a98c:: with SMTP id s134mr25887179qke.176.1562083245386;
        Tue, 02 Jul 2019 09:00:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k33sm6569045qte.69.2019.07.02.09.00.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:00:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC38441153; Tue,  2 Jul 2019 13:00:32 -0300 (-03)
Date:   Tue, 2 Jul 2019 13:00:32 -0300
To:     =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 32/43] tools lib: Adopt strim() from the kernel
Message-ID: <20190702160032.GH15462@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
 <20190702022616.1259-33-acme@kernel.org>
 <CAGje9yTfFrUxj-vSX=Au856Fe_307aQqD=YrbGeWfHESQ6Rw8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGje9yTfFrUxj-vSX=Au856Fe_307aQqD=YrbGeWfHESQ6Rw8w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 01, 2019 at 11:33:20PM -0400, André Goddard Rosa escreveu:
> On Mon, Jul 1, 2019 at 22:28 Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Since we're working on moving stuff out of tools/perf/util/ to
> > tools/lib/, take the opportunity to adopt routines from the kernel that
> > are equivalent, so that tools/ code look more like the kernel.

<SNIP>

> > +char *strim(char *s)
> > +{
> > +       size_t size;
> > +       char *end;
> > +
> > +       size = strlen(s);
> > +       if (!size)
> > +               return s;
> > +
> > +       end = s + size - 1;
> > +       while (end >= s && isspace(*end))
> > +               end--;
> > +       *(end + 1) = '\0';
> > +
> > +       return skip_spaces(s);
> > +}
> > --
> > 2.20.1
> 
> 
> Small nit: could call skip_spaces() firstly and save its pointer to return
> later and then remove the trailing spaces. That’ll make strlen() iterate
> over a smaller string.

Hey, this is just  a copy of what is in the kernel sources, so as soon
as this gets improved there we'll grab a copy again can you do that for
the kernel first? :-)

- Arnaldo
