Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE383C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A59206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udFUdL8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLJFV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:21:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38747 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJFV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:21:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id l4so6903345pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 21:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UwrjfcwYOpJ2xyBggWtxzeNIKMmDC1O3C+UcOTm1Xww=;
        b=udFUdL8CSxus6OzfB/32Akgca8iH+TWrJcNBC/YP+Q0AJlC8f3KAaeUq4ScXEQYuDj
         dF+3ht1yZMp6VyZmBC7jD+TjluEHT7toSwbUQCnf3yQPBTK98aEhnTpfXwb+Lw6+pFsw
         jylyk+mQtGNdMW2zWkDBJ8EDUbPl9JxWn4q2lSoLNhT+MGd15m5upQbDbodDolGRQow9
         OIKZEhJcurBjpKIqHhZApr7If3y83ALUiNL2jWHc7SdomEZ39WG6ExFafeGjZLvfGakr
         c1WmU6MSmqEOMk/lfJIBE5QTA+v4JbrQBDcGIpfEMKAytoLYNxTUTsA4v3RW+uYPyyrk
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwrjfcwYOpJ2xyBggWtxzeNIKMmDC1O3C+UcOTm1Xww=;
        b=qMX8HsG8tq1LmFyyV3G1vz+4L41bYdC1no7osjoHRMczfdIEoKkjF0qqrYDhdZWhiY
         AaieHNvv/vtBoLQXlh9nGFZs2YZRfdjjFGIKPFhl1W/XA8UDh288PU6cpX1ZdePswfuG
         0mLyrsl6WbStkxQTHyqn2eoNyW9/4WljbvNuwu8yKdZnbfq8Kvl36MvIIRfRdJBNIrEw
         OUlcQIYy7cyDtuCsUUPjOarx++qz1AEa3lA0uxTZ6V2dCK//bJtEXEz5xJNebF9S8BGK
         5mGzMsMb+e3f0Nt9CtXhS1aQO/PV1CdqsCcx6Ib+T2qmoOzo4JrHx4uMus0tmNxArnNY
         OCjA==
X-Gm-Message-State: APjAAAUCAy2Xw7IZzKlEkMLAkEUWbqiBXWdeMoyjM/hA5sYLnOYG+ig+
        BUcdlcyKXm/0jiAnvyp3pT8pzA==
X-Google-Smtp-Source: APXvYqwMzFhVumk/TT/0klj6VgiAr4+TABdqJa4cB/e2LE3l4VmhXXIHNFhdSTEQZ65fOSqgnKLDXQ==
X-Received: by 2002:a17:90a:86c7:: with SMTP id y7mr3405878pjv.102.1575955288349;
        Mon, 09 Dec 2019 21:21:28 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id v7sm1075946pjs.2.2019.12.09.21.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 21:21:27 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:51:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20191210052125.qg7zlbxo5ag6er2g@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20191125112952.uwrmeukppkqu4hvm@vireshk-i7>
 <CAGETcx_uohJknvW8pDb6XXBkZveFqMvt5wRyecV5sye5a8vLpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_uohJknvW8pDb6XXBkZveFqMvt5wRyecV5sye5a8vLpQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-19, 11:11, Saravana Kannan wrote:
> On Mon, Nov 25, 2019 at 3:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-11-19, 16:58, Viresh Kumar wrote:
> > > Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Date: Mon, 25 Nov 2019 13:57:58 +0530
> > > Subject: [PATCH] opp: Allow lazy-linking of required-opps
> >
> > Forgot to mention that this is based of pm/linux-next + following series
> >
> > https://lore.kernel.org/lkml/befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org/
> 
> Thanks Viresh. Is there a git I can pull a branch that has your lazy
> linking patch series and whatever dependencies it has?

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/lazy-linking

-- 
viresh
