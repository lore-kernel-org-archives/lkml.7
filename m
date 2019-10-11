Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2348C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7704A2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Opywxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfJKXZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:25:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40733 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:25:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so6625175pgl.7;
        Fri, 11 Oct 2019 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HnsIqNSAtnoJLnhTI4m9IprOfs8bbDJOo1Of/k4CbPs=;
        b=D+Opywxho/fylFT2LWEAP6j5OPPr2dqlzRLD4+iZVbtAOYC2H870MSixJjPbT+a2R7
         bRKx0sltCM9ClNnea5U/Te9lFaIaDO1ftD43XzpWZweD1itONjyjgPaxOl+Q9QP84GiN
         mMtIDQJ2FikqJU7gEvRVRN3YW1Jd1JFVWEfYXs/kZfpZK7U1g9U+8biY74HvfB4CuJoG
         gqj6zj8SklOgvbby165385jGh9EJcePEoQmVlVz0pGkQl4VjmKAV2zB4VC3FIMxAVXQz
         z3agur2s4+5oqAMglWLeb5ahYTQbaVLU19+p85RVlX8hDK68ZtKokjxKvWpbUdZTorpW
         faaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HnsIqNSAtnoJLnhTI4m9IprOfs8bbDJOo1Of/k4CbPs=;
        b=ODISBCTuCGp/4+x/cIR4f1zfBDRZUX3odGqH0jQuMauGIm/8Pae3PDK+e4Lvz7x6qS
         QuX+1dYBnHzfIZ1y3DBg8ZmgG6VCHjn0fz3dwI4NWc7cYj5l4EsFQUcC1/2CrhPQLqzO
         apuqxgAbADpKZxeJ0BFIKGksV8Pnp9/WCsFjsv7ZQe4S1dDcy3zpTtKxT1DWW5PHNyWc
         LSQMMNegQTOAzOQFVBEO/oPv/6ijgfzS2gZ8Qg7ohmIFs/ZEWQDIjOfmFfhQwVxueOIm
         AtJckvAofG8gGxpcApT7AQWzxjT/BQ+59mv0WCJnrzBInUwRWsl2o9QuNgpdqvc0Zr4G
         VDCA==
X-Gm-Message-State: APjAAAWzLMARZcVVhRyZNK9gv26JktSiEG1IKcoiZ20DiIbqd0DhZ7O1
        /RVFig9c55F2JH2nEqwsO+g=
X-Google-Smtp-Source: APXvYqxebJmOFiwTGaq1+voYZcoiDHsNHOIOYRtB9AW9N6yBuO+rivRsq8DOFpc/+AFF1oYVf9C0Pg==
X-Received: by 2002:a63:28f:: with SMTP id 137mr3636145pgc.336.1570836328408;
        Fri, 11 Oct 2019 16:25:28 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q76sm23268116pfc.86.2019.10.11.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:25:27 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:25:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v4 00/14] software node: add support for reference
 properties
Message-ID: <20191011232526.GL229325@dtor-ws>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
 <20191003003227.GA246700@dtor-ws>
 <CAJZ5v0jF5vafYFSJ=p3ew_tCbj1T1zRznZDoPTL47Pdj9-rrCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jF5vafYFSJ=p3ew_tCbj1T1zRznZDoPTL47Pdj9-rrCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:39:24AM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 3, 2019 at 2:32 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, Sep 10, 2019 at 10:12:17PM -0700, Dmitry Torokhov wrote:
> > > These series implement "references" properties for software nodes as true
> > > properties, instead of managing them completely separately.
> > >
> > > The first 10 patches are generic cleanups and consolidation and unification
> > > of the existing code; patch #11 implements PROPERTY_EMTRY_REF() and friends;
> > > patch #12 converts the user of references to the property syntax, and patch
> > > #13 removes the remains of references as entities that are managed
> > > separately.
> >
> > Now that merge window is over could you please take a look at the
> > series?
> 
> I will.
> 
> It would help to resend the whole series with a CC to linux-acpi, though.

Rebased to next-20191011 and sent to linux-acpi and others.

Thanks!

-- 
Dmitry
