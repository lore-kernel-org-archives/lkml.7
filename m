Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5AE24648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lFMXFtEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfLESLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:11:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39160 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:11:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id g1so4402049qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=giazvTsGDVrAkD0F11ztp2e1h3nTDeaUJG0efXt9Qrs=;
        b=lFMXFtEcWUl3vJMrunz+yvhUAHmdxhRsKYC0p7Ww0hm9AofnOkELBIELu3Y54o+WBW
         novXm1JEjC85nkqN6PL53QjDNkdrPwCN36KDxMm+6zGCn8/oq0+btL8PR972iASQLSq2
         OSIUYWIvaSUXx5OcYje2nqq6KTSyBnjhr+jeeXyzkwNzIjgUpYOhR5OUvIPgj8xhODnd
         ih1iXWDSE7ssl9uKceGzrbcY5aEwHaVd2j5OfgxkzP+6qS1Jq8uXjdH9W471R/yLTybl
         UXlPvsTwbuFRbCoH7k3IiOR/tBOzGBCW9oSHaukPeSItSueq3tqES/4Jx+Au4j+MBIzX
         ykxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=giazvTsGDVrAkD0F11ztp2e1h3nTDeaUJG0efXt9Qrs=;
        b=TCjNmQZgpnIGvjhLMRDiyxRIhXGbNKoJpvZQjWF8ZOje8L0KIPykJkwD+S916MG60v
         QGZ5e5UNJLvJG+IZ0sICFgGwSEJzX8BULfq8G7p//OPoysgyB1hfeMnUrXnPIdur6aBc
         0+t6GZYjMlZaxDgn8ExHkuEedr3j4wroXG07qT9RvLL0ctJQjsf4ZoGnw0YV/uYTISyZ
         6RZr9xR/yVWlWwHxqG0C+TNbe68GV6R1NsrDT7A10q2F83u0CH1KbhO33rCOHHM/eWY8
         Dew3yjI9ZpbQkMGkQ5Xq+9EqY4ySDAGSrfnmbi2NngHA3CMVNNT59LJbX87Ge2TSkwzx
         2ReA==
X-Gm-Message-State: APjAAAWe8Y3cjNRpyvsAbFd0u0g2g8tJYGOLLb0TdglIoAWtCzSGc+WL
        FmM1CfpbfrbxcS6xe45sT3iB3w==
X-Google-Smtp-Source: APXvYqyAWzrAYSXDcjIG4gMKpsUjXiPIN5Oj6sKdEq19PPy08baLSSvxwi0IrUd/1m+F1gSsOAOZNQ==
X-Received: by 2002:aed:2805:: with SMTP id r5mr8778816qtd.335.1575569513941;
        Thu, 05 Dec 2019 10:11:53 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u12sm5589261qta.79.2019.12.05.10.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:11:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v2 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 13:11:51 -0500
Message-Id: <1707CDD0-E05E-411A-A093-35E8E50ACA4B@lca.pw>
References: <a16b53f9-92c9-ff01-06c1-530647ecaff1@linux.alibaba.com>
Cc:     fabecassis@nvidia.com, jhubbard@nvidia.com, mhocko@suse.com,
        cl@linux.com, vbabka@suse.cz, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <a16b53f9-92c9-ff01-06c1-530647ecaff1@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 12:39 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> There are definitely a few inconsistencies, but I think the manpage is qui=
te clear for this specific case, which says "status is an array of integers t=
hat return the status of each page. The array contains valid values only if m=
ove_pages() did not return an error." And, it looks kernel just misbehaved s=
ince 4.17 due to the fixes commit, so it sounds like a regression too.

=E2=80=9COnly if=E2=80=9D  in strictly logical term does not necessarily mea=
n it must contain valid values if move_pages() succeed.=
