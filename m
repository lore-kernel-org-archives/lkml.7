Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1950C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A098F2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsExb3dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCKO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:59:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37727 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:59:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so5361394qtn.4;
        Mon, 11 Mar 2019 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZeNXlhRe36+7xYWVjT8tpzBUmk4PuZMnszNDboEKFwE=;
        b=SsExb3dX+6+ywqzz7GlxFpJkZyyf42ysIdP20m1F5c3J4B8DS5fvzNH8jk9ZGtBPDd
         tqj+LBkt05kCWU066b8VPA/NgU2s5pSsbcx2OQMDdF7ClQUL8eFD0Poj4SBpMeHRqPz/
         eyF1OYfIOqb9nP2n9GZmQub5bvWyCwEjDtbzFusFh9GIkgNglofNSiGMADi1ODS27yLH
         apMliYgDnXd7KPQ05peUxoz1MW1vJL+iJbkPl1zoylW+yEF8SX6bdwFhjvtYJtAQuw7W
         h5yDdqcH3YLanj9Wx/nJmUHIKmyuLhAFss+sy2NBOxFSqaTnEwZz0nHc39IF2KAAiAgu
         aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZeNXlhRe36+7xYWVjT8tpzBUmk4PuZMnszNDboEKFwE=;
        b=UkeYd9JfIiclGfY2avp8rVBQ++BkbXtq5f0eZhsPht7cUG4Cy2BcVxaFuwFwbe+J2o
         SZmcuN9iNUNB8TxaE/fxuDwfgSOl0yxfMxNHgO6v7JCMsKN19NDElIJLg1uvw7r0hj+P
         Q7yaxfmDx+f2HLVkfZdtqD94xL44uy2Yv0+rO8m/q66ia9fwhoqQkF5Vi+J2mtzDVBTp
         t+afAdAaBXacv+9xZfCjGAPP/G6OE46+TRTvIsCouLwLCOV0AJWpq1ABGyTrEd0qn8WP
         n/K0NDIWgHBGhvBmsqoN5nKxF3dFsjpzCs6WX/iFCoCqhsKDIiGqivNZTP5qNngf4lEm
         Ohnw==
X-Gm-Message-State: APjAAAXa7EdeW4lUankLvvCSOD8ojRW6xSmLiUvgY5/gGqt/X2zTBulj
        R+zA0zH/khKaTtaDHWQlBIg=
X-Google-Smtp-Source: APXvYqzfAixFooeaDmKhwj39mqFh6hHDBEollZMwK+k4gn70xTrY8+ESNfPB01eJ4lfaanUeMWVObQ==
X-Received: by 2002:a0c:8850:: with SMTP id 16mr9455519qvm.111.1552316350015;
        Mon, 11 Mar 2019 07:59:10 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t38sm5097408qtc.12.2019.03.11.07.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 07:59:09 -0700 (PDT)
From:   "acme@kernel.org" <arnaldo.melo@gmail.com>
X-Google-Original-From: "acme@kernel.org" <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CDC74039C; Mon, 11 Mar 2019 11:59:06 -0300 (-03)
Date:   Mon, 11 Mar 2019 11:59:06 -0300
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Tony Jones <tonyj@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] perf script python: add Python3 support
Message-ID: <20190311145906.GM10690@kernel.org>
References: <20190309000518.2438-1-tonyj@suse.de>
 <363DA0ED52042842948283D2FC38E4649C48CE08@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C48CE08@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 09:27:07AM +0000, Hunter, Adrian escreveu:
> > From: Tony Jones [mailto:tonyj@suse.de]
> > Once these are applied I believe this is everything needed to run on a system
> > without Python2.
 
> All look fine to me.  Here is my ack as needed:
 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo
