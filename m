Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1EF2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWCkJK/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCRSPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:15:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41302 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCRSPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:15:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so13754404qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kV8a2UbDLeRMV1l0U03pVIZ4VzZ3DURcOYS7fGVegr0=;
        b=BWCkJK/gvpssxBCk5bWXsfGSPRCNi1hxHsDyw70dfTyidqSpP5i77qeZQjSk+goYsX
         utglR5XTDD64yae5/sYaZyQAcCPnK5iWH3Jh4z9kmDbODvLAW7rJXZ3lkIgsnirk3gTV
         V9uemvPQ/L1wfZu9vviX/uGA8tCGXV3ffXMcTo7KJGMY7gB1GCrS+9TX2YvV58pjIDD6
         7LPXDqT4hP5wUeRbPdWl9Nv4yIKuXXx1+5jls5/FMnJsfVjlayFG3GC167FQXH8vlHwZ
         kyYPGF7HAGnsZjKjkqr7+k7aMzrwFRvghY1LKPLlWOlxBGnXGhmVRpSZf0voAy+DfGcd
         q6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kV8a2UbDLeRMV1l0U03pVIZ4VzZ3DURcOYS7fGVegr0=;
        b=qWpXmFLvhUVz9bh3pSKAVtfYkTKBHP4s4GOEE/Y0jP06pZTKP8J5Fy7p1g4kLdgu1i
         mTw25GAb6jK6oIp1SmXF2k0HNFdxq632ZgcCdwLk/oHejWun6mpSFBf56Rd4vPPK3yse
         Anbtm4v3+uzzDG9bbn+spT4f4hc5GmpHYT5DEXn52OB//i05O9tAMiVXrsKHSFQjpaUu
         6snh7RO9kAxswZ6ZiygIhTuFS2T9KX7himxkcQ7k0Kxj9JY6adPDCu5bP6/IAZA45icw
         cqLnldE6XdcvvCzD5CN3TUlHqh7UqjNoSh/NbcM9g16QAell5e5O1W/Jknmr+SfBm+0J
         6PoA==
X-Gm-Message-State: APjAAAUA28/9ZGt7PXFbazt936trSOKbfZS6q3Q0JJ80D5yO/cHBRAVX
        QKTwfxsnhgoac6T0JJP0I5U=
X-Google-Smtp-Source: APXvYqx/XLudeIvB8qu6BiXnB24oy2jyFa1Y5BKSmH8LMnfMJkxkae1Cyg5JP2KUrv6NUBG+0rohKA==
X-Received: by 2002:a0c:c607:: with SMTP id v7mr14170280qvi.188.1552932940694;
        Mon, 18 Mar 2019 11:15:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.179.85.138])
        by smtp.gmail.com with ESMTPSA id z190sm5744304qkb.9.2019.03.18.11.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 11:15:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59E6A4039C; Mon, 18 Mar 2019 15:14:30 -0300 (-03)
Date:   Mon, 18 Mar 2019 15:14:30 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
        peterz@infradead.org, mpe@ellerman.id.au,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        namhyung@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH]perf:Remove P8 HW events which are not supported
Message-ID: <20190318181430.GA3967@kernel.org>
References: <154953186583.11022.14819560028300370163.stgit@localhost.localdomain>
 <d185d075-8589-5ec0-f3d7-4d5c79d12aed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d185d075-8589-5ec0-f3d7-4d5c79d12aed@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 26, 2019 at 09:25:40AM +0530, Ravi Bangoria escreveu:
> 
> 
> On 2/7/19 3:09 PM, Mamatha Inamdar wrote:
> > This patch is to remove following hardware events 
> > from JSON file which are not supported on POWER8
> > 
> 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

I'm applying but next time please add a Fixes: tag for the cset where
those events that shouldn't have been, this way the stable@ guys can get
this fix, also, something like "According to documentation
http://somewhere.ibm.com/DATA-sheet, etc

I'm trying to do the Fixes part.

- Arnaldo
