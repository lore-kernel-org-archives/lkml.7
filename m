Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B534AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDD4217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sa9WR5qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfF0EQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:16:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42031 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0EQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:16:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so370390pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6gmGlKkeqWK/vz05TafXDuU/dsP6RPyTWS+m9MTdDaQ=;
        b=Sa9WR5qoLPyRTseXtozsm/nm3JiSZHZntSQIi2UVlFapQhPDvxwKtn7f3DVNvE4Ojs
         KQKqFPrujlfR5k6yWemovrOFA+HGURYa+f9Qv0UuShjdurOEAqY+odpgMjdm7wuvn3nG
         jVfv4XW7NjtlGZoLjFcOTi4bzaf1p4GtoRqQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gmGlKkeqWK/vz05TafXDuU/dsP6RPyTWS+m9MTdDaQ=;
        b=iK5EuqwUvxtsSA+xvEcjCPXtkeqw93BOR039g5XJbhHHpzN8IMkBCzJ+NzSL7TFHTR
         IndNrdvKBkWYYDrEAPLaq4NJJNpqz3/CIWq36CyDAPFLDmI9saz5F8SD1sVVtVSHqViC
         0hAz2jgSoi75HedSQMkCV95Fp50ybwwBI3TVKPMTEb6+XA2msr3JTGCVWB0YK8kKhdPC
         8FRMcTZiDEhSbrqXxDl+rEnpDqIWpqj/UmWmYArkZnMPUys0nrgGvTcsiZCE6CGtkG7U
         Zlf8HwsXDf39Mx2Xu28U5UIJ1YUcxooaQaj1qH3+cTQepLkZOF4LjI762gLSyP8pZ8HK
         +r1g==
X-Gm-Message-State: APjAAAWa1VGNlyDsQwDNxe5ySk8oQ+MLQWvbc7Oy0HYMKxgwYrDgpFh8
        mJHN1be/70cW+DsZoi8lUjl07TpyoSU=
X-Google-Smtp-Source: APXvYqzjHWC/IYmnMqP5JiyMycCyiDn9+OIPaCNfkYAuxgSu3TAep5hU0SP0G/yoNUeDsh390He9Gw==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr1682686pgm.152.1561609006707;
        Wed, 26 Jun 2019 21:16:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm927324pfi.63.2019.06.26.21.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 21:16:45 -0700 (PDT)
Date:   Wed, 26 Jun 2019 21:16:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <201906262100.00C1C22@keescook>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626162149.GB4144@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 12:21:49PM -0400, J. Bruce Fields wrote:
> On Mon, Jun 24, 2019 at 05:05:12PM -0400, J. Bruce Fields wrote:
> > On Sat, Jun 22, 2019 at 01:22:56PM -0700, Kees Cook wrote:
> > > On Sat, Jun 22, 2019 at 03:00:58PM -0400, J. Bruce Fields wrote:
> > > > The logic around ESCAPE_NP and the "only" string is really confusing.  I
> > > > started assuming I could just add an ESCAPE_NONASCII flag and stick "
> > > > and \ into the "only" string, but it doesn't work that way.
> > > 
> > > Yeah, if ESCAPE_NP isn't specified, the "only" characters are passed
> > > through. It'd be nice to have an "add" or a clearer way to do actual
> > > ctype subsets, etc. If there isn't an obviously clear way to refactor
> > > it, just skip it for now and I'm happy to ack your original patch. :)
> > 
> > There may well be some simplification possible here....  There aren't
> > really many users of "only", for example.  I'll look into it some more.
> 
> The printk users are kind of mysterious to me.  I did a grep for
> 
> 	git grep '%[0-9.*]pE'
> 
> which got 75 hits.  All of them for pE.  I couldn't find any of the
> other pE[achnops] variants.  pE is equivalent to ESCAPE_ANY|ESCAPE_NP.

I saw pEn and pEhp and pEp:

drivers/staging/rtl8192e/rtllib.h:      snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
drivers/staging/rtl8192u/ieee80211/ieee80211.h: snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
drivers/staging/wlan-ng/prism2sta.c: netdev_info(wlandev->netdev, "Prism2 card SN: %*pEhp\n",
drivers/thunderbolt/xdomain.c:  return sprintf(buf, "%*pEp\n", (int)strlen(svc->key), svc->key);

However, every use was insufficient, AFAICT.

This:
	git grep -2 '\bescape_essid\b'
Shows that all the staging uses end up getting logged as: '%s' so their
escaping is insufficient.

> Confusingly, ESCAPE_NP doesn't mean "escape non-printable", it means
> "don't escape printable".  So things like carriage returns aren't
> escaped.

Right -- any they're almost all logged surrounded by ' or " which means
those would need to be escaped as well. The prism2 is leaking newlines
too, as well as the thunderbolt sysfs printing.

So... seems like we should fix this. :P

> Of those 57 were in drivers/net/wireless, and from a quick check seemed
> mostly to be for SSIDs in debug messages.  I *think* SSIDs can be
> arbitrary bytes?  If they really want them escaped then I suspect they
> want more than just nonprintable characters escaped.
> 
> One of the hits outside wireless code was in drm_dp_cec_adap_status,
> which was printing some device ID into a debugfs file with "ID: %*pE\n".
> If the ID actually needs escaping, then I suspect the meant to escape \n
> too to prevent misparsing that output.

I think we need to make the default produce "loggable" output.
non-ascii, non-printables, \, ', and " need to be escaped. Maybe " "
too?

-- 
Kees Cook
