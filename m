Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7F2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573839915;
	bh=H7+Cvy6riOyJSBuDWiGVZHG8QS021N3D0nsJUzTOrMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZ3kN5zrXdLCcFVTig0aqK9Z8j2/bwtpEgkuo2SQuXszgdtrzamil6GCChiy0JdZZ
	 bwhXDP/23whVX1wds5stYPeJMmjcRUeQDgaAl+fulTAvBb3laxH7tWW6hVlEc0YHkU
	 SUxTERt+X5wm0ZJ4LCcRyyLGzN1oxb5SyHePmYp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKORpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:45:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34487 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKORpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:45:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id i17so11663851qtq.1;
        Fri, 15 Nov 2019 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YuU96D/TDOxMsRo5MUSuzz7CtcCcjXftMIfC3UuPqHU=;
        b=pPGEq/7QhVZhrqpLch0bLyj/72nqtgSOl/IMPgAAmVYSsb/fRFxcnszz/kWfmiVeiX
         qK1uvlLMbsbFmDfDJppVIkeWYm2SIamy03myVeeNOFkkjpYlcLM4KGVtP8f1AlPJmFa0
         nvyUPYX0eBdDhMhIs8O1RuIwGjSBbGQCZOewWNUZkIcuLzwRbmKlcRkfaj3BKSHfQ5iB
         dRmWsSYTEKp8UBfBfgLcndjAG7O+1WTjfubUSepVafd69mLHoSnQTbFeCe77pu+0/fEH
         MoHr4DovkUADP32hUfqrkedITCc0DSJ5QqqfCraZRb/B/SKet6twIAOUHUzTTxddh5Kf
         P3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YuU96D/TDOxMsRo5MUSuzz7CtcCcjXftMIfC3UuPqHU=;
        b=M7485x2oL8EGheCtdG768IFJtbvY/zy4bP/lup+FM2bggu06Mu0nHZyNNCc9a7AI3j
         7bJMc+0L61n6Nq+ce2KLkqPe9yttVN2e1zUAXj4D+GUCS5eJr6iTRNs7KWETPMOAEWPi
         bvHmfRAXXDZY5tvRh4Le6mW6Rg3ZPrdPebW7KYiWliadUZGgQfLxzjnQJxL204nksF/S
         bmV4Y69FjPA0+eTx0AysIn89D/czpKDMylP9BDqmvC2eOGiQiE2YabFUsxHFrylj4Sqh
         16CC5Mz/QqCtdxc+RGYXTyVM9EIJ+vxhPrhMnruhe9ngGqxWLqWIdy0Uwe6ySL5DwtYV
         iEpg==
X-Gm-Message-State: APjAAAVWxxQkNgnK5PS7Zaqhj2d9A+mlBQ6J9X9nszPudYOLaovAHHTB
        gFhxsRpGwkIE81/i9hs0f0U=
X-Google-Smtp-Source: APXvYqxgWGBD0NsPXWgJtmgUpYkbJPfQov6z2QUrwYyNakgEJcyuhrIgXufSFdsr+gbVuvan+NoQAg==
X-Received: by 2002:ac8:151:: with SMTP id f17mr14536642qtg.92.1573839913365;
        Fri, 15 Nov 2019 09:45:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::4ef1])
        by smtp.gmail.com with ESMTPSA id w5sm4347404qkf.43.2019.11.15.09.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 09:45:12 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:45:10 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191115174510.GQ4163745@devbig004.ftw2.facebook.com>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191113162934.GF19372@blackbody.suse.cz>
 <20191113170823.GA12464@castle.DHCP.thefacebook.com>
 <20191114191657.GN20866@dhcp22.suse.cz>
 <20191114192018.GJ4163745@devbig004.ftw2.facebook.com>
 <20191114193340.GA24848@dhcp22.suse.cz>
 <20191114193736.GL4163745@devbig004.ftw2.facebook.com>
 <20191115174031.GA15216@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115174031.GA15216@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 06:40:31PM +0100, Michal Hocko wrote:
> I am sorry but I do not follow. How can css_tryget_online provide the
> same semantic when the css can go offline right after the tryget call
> returns so it is effectivelly undistinguishable from the case when the
> css was already online before the call was made. Or is my understanding
> of what Roman's said earlier in the thread?

It's *exactly* the same semantics as opening a file and deleting it
and keeping using it vs. deleting a file and then trying to open it.
You can't give out a new reference when the entity's visibility is
expected to be gone already and that's the exactly the condition that
tryget_online avoids.  I don't know how to better explain it if the
file analogy doesn't work.

Thanks.

-- 
tejun
