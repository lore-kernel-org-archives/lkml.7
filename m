Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9228220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP/zBpHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCFVLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:11:51 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:41307 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfCFVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:11:50 -0500
Received: by mail-qk1-f173.google.com with SMTP id y15so7736143qki.8;
        Wed, 06 Mar 2019 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/ukEnRExFgfVOp2LYzsEZ0Q6fCuiDjRuQCn5KNUDug=;
        b=dP/zBpHwhXaCVu1uCbs4Oljns4wITArKiEDdMISZGdbfPmhu/q+tCUEiBHwYnieV4F
         9D/pHaUFgRsGGzupJjdl/q8cKif+widzqaWthYNHDzwnKYi+PHE0J+1/NOFaJKLBRLvB
         hYZ15tpUE02v4/4tdXgXg2lKT8D79hk0N6Lx+kW5mCS/G1giyG2+yFLtjs1gfZTWzDtz
         L0yzxPLu4UkribFlG9DYRL9n9Mzf/Ea1cnbR2JDMExEMgq1Q2hvpwcw/eURSuiTJ/2Dy
         ysSZ3Ue7lcgbrfQDnDaCaPvMJY/CGWk4M3+Qk0y7KYxtJm3WIAJ2+bCHFfvlh8ij3O7h
         U2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/ukEnRExFgfVOp2LYzsEZ0Q6fCuiDjRuQCn5KNUDug=;
        b=hBXQUL+8npP24qbHz8HXGAKh1u4lq87J/oqVoyNjamIjjaer9iox0wOHO/ValhoqFT
         IMAngs3h55I3z2UjGctS9tK0socL/SnalZRJ4ZaSHMuSYnW5fwJagVPnwzuHAU3gOWdX
         NB1dlUsYRGztv/gn7MjNHjk4oc+40WXq+/Uyq4a9XZsGl+0uq7J6nflDVgzxZ3XoFANe
         guMWshxE+6gQnQPd3CxAczfNsEGgu2aKAq0xGZtjhkh093ZuAjWfd2TSqsqZDSaFJDUL
         weVufHWYPNn/cgy6laVrr6l64IOkXRQhe2S2gITlXLOvYHJPvGh0RmZ+zHSvObQ7IiVe
         kpLg==
X-Gm-Message-State: APjAAAUg9rJXP9XkbyML6DSrLm7ns1AtLz5vn45BmHV+OHXONYIlpZIy
        b3ocwgdHM3L42vwVSrmfwfs=
X-Google-Smtp-Source: APXvYqzjdbfDoPbKjtb7O0hoLtXl3Cx7q59LEc5GFSnDoxYv87MxfKaKnHEwc9IIEdW+QiuPBEbTkQ==
X-Received: by 2002:ae9:ec0e:: with SMTP id h14mr7457126qkg.301.1551906709445;
        Wed, 06 Mar 2019 13:11:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y125sm1591071qkd.49.2019.03.06.13.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:11:48 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA46A4039C; Wed,  6 Mar 2019 18:11:46 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:11:46 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v2 4/7] perf script python: add Python3 support to
 event_analyzing_sample.py
Message-ID: <20190306211146.GP30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-5-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-5-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 05:19:00PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the event_analyzing_sample.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6

Thanks, applied.
