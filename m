Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A882073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575422590;
	bh=2+AB+f73bqLJzduOFBMqOP9+SB5KN6DIfTPAuBs6E5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BeuZf+3zHNnb6Lv9D9z16gX7I2YPG6SuWtwuG92AYveZZFHhcjArBCnuKMzYx6vMi
	 JoftMbCze1ByLsrW2xlXzHIGoR+8XRXxgwmgePsspJXqfL/GSLXYT1APy/wQD/XzQV
	 WG7iuqyFM6OaoA3GctBgHZNQmkUdfVEk6ZeD7Xok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLDBXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:23:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43912 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLDBXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:23:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so2482947pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RdmqY4oDKtkPpypxi7Kh8+j311Ee1N23HfoCEktoufA=;
        b=bWl+3iqyGreCm1nHNU4qFgfzczaWtkekwTPQqZkKOVn2FzRuTRiABxAoX77rpsn9WE
         dMoJ0TPGtCyALQ/IsYv7P1R02FB53/H8A972JEil9gQdwFNHlbOJr6DCWTO9s+cQoYw3
         6rBxclhF/Xan0X6PBh9KQd69N/pgD84zchE4IYPQZ99SsJxrg310GoHPFa0F4Xjn+FBv
         8lDQV10aeAcotUHL4IqpoRIgkj49lLU3vz+VQIG7H9XohTf9R8HIwWlcgwsrCY6btBS/
         RTH5fGJAlOZad6RjPEVlHun1LnRHKI5kUiwqvgmKV9Io3LZkFSSWgoCsrh7ohchtoFdL
         AOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdmqY4oDKtkPpypxi7Kh8+j311Ee1N23HfoCEktoufA=;
        b=oAyKPQEQHutigecctsrnoWx1PSxooZTByhZRVxMFMIB+N9zeStaGW5hTV4pQFcqIPx
         hDRmxFEXisS1aZByTGnT1EO+gAp9FGwSXDt0uhv8nRzooehG9lPBXJFERjLAfQGVOrz8
         gdkjHpfQk7Zb8BSUmuUhB5vkz52EHIiMVfUHZWUyt8g1mI+V+JAVzWy54+zGqEa1hDbg
         /eZqt6yxqavdo8omHUU35jmw6MvFq4+z8/TeJdu+K0kBPv8jssa1uv5kNAF2ChnWtGL/
         prrHkcVa2OiRp2cvN6qy6vjymKRlApWyEcfG3QWtFScMyM5z5S2mpaLVwxDx1Bft5kjd
         waag==
X-Gm-Message-State: APjAAAVevO/aqUSpTwpsm+wJX1kFWuIPYdTro0JToFn+TD9x2qC52WPG
        QZ2GVzEx0slshu+UUvgHL3I=
X-Google-Smtp-Source: APXvYqzN84PpLqpb9wjSoodLisFlXlzrha1mDasbD17OYY6k/ATAfLZ7ZYa8mexhsCzIVOJJd+45Hw==
X-Received: by 2002:a63:5612:: with SMTP id k18mr706902pgb.345.1575422587680;
        Tue, 03 Dec 2019 17:23:07 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id u9sm4841305pfm.102.2019.12.03.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 17:23:06 -0800 (PST)
Date:   Tue, 3 Dec 2019 17:23:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chanho Min <chanho.min@lge.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seungho1.park@lge.com,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Jinsuk Choi <jjinsuk.choi@lge.com>
Subject: Re: [PATCH] mm/zsmalloc.c: fix the migrated zspage statistics.
Message-ID: <20191204012304.GB6629@google.com>
References: <1574990967-23391-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574990967-23391-1-git-send-email-chanho.min@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:29:27AM +0900, Chanho Min wrote:
> When zspage is migrated to the other zone, the zone page state should
> be updated as well.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Jinsuk Choi <jjinsuk.choi@lge.com>

Hi Chanho,

It seems your previous mail included fix and stable tag was mangled by
HTML mail. Could you resend the patch it unless Andrew pick up?

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
