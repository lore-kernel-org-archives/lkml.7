Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCEC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BC12464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cZ6Nlkcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfLEWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:23:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34424 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfLEWXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:23:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so5168928qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 14:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=s9HuZFqazi071tR46CJtidfMMQKEUIWC1jwTBGYP1+w=;
        b=cZ6NlkcxxGeMFCfa3hNffYbt0adwBZu56/wsfc7GzrfjY7exDtzAzT69JkqoOcFpm8
         f/DyD28W+DSoWxWBnipzKKfbHXYFVd1KXHBALe7U92Rlb0TUsWCVWecCbyZNfsdy5b+Q
         umBbiwYYXAJFbsr4PPSFRGm5XP7lnsOzGREK8bLhFcBl19HybxYqB34HQGQBygroaZYe
         KTHKnPrku21QGMQky2zEVpbt8qArb3r30PwDE6ztueSyGlJ4chmylOb3WfxksBOp/SdP
         88RI15LyNSV036ykGPGm2olovdquCBRFsjwq8Y8+9XHkNtSjyAb5qjPcekWz2+rrhUQ+
         omuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=s9HuZFqazi071tR46CJtidfMMQKEUIWC1jwTBGYP1+w=;
        b=ucV3nTn8t7s0hQqxqpsw4ZVsmj/hW6ao5PPakg8SjYjAu9HyZBl/x9+WvbZAE8S5el
         kz8HKUrw8qe3+BVTYo9avaXTMQYkmNQxM41s78UQ9PCrEZ4fOTw3PLxcq/Jjwud9YWhi
         IUbTV55Ubboket27611TE8JQrrIwVuBKqKSP/cAcLUF/bJ6UgxONY58X0tntTNSA394a
         cIO3fFJe0ZEFexfMMdCSF6YGF5Ai1xBuV4rM0Uq5JRBeMd4Jxp9gCttWXqYY+sAiKeeo
         qiIF3qI8SARJNKAKEOkxWbRUaqoBAtj0LD/gfEOxaMCqlbCHtLlZRuS+LGtT8qA3DCDd
         8RDA==
X-Gm-Message-State: APjAAAUfHsPi4G7S9NZ0cG1iyDhSZJDnBEt5gzok86ZrM2oTKNehllSn
        P7cjo/0O5T56p8muMs+ZnOlD/w==
X-Google-Smtp-Source: APXvYqx7GJ9s3s0mo7mEDapHflc+9TKM5IVSvrVc5pjmpmXIK6z7WiQr0sZpTn3eRDhYfRmpclVinA==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr10371261qtn.43.1575584626599;
        Thu, 05 Dec 2019 14:23:46 -0800 (PST)
Received: from ?IPv6:2600:1000:b06e:b1cc:9498:2fee:3c1:2a4? ([2600:1000:b06e:b1cc:9498:2fee:3c1:2a4])
        by smtp.gmail.com with ESMTPSA id k62sm3911034qkc.95.2019.12.05.14.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 14:23:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 17:23:44 -0500
Message-Id: <D04891DC-0EE8-4EA0-8541-97E4AB4DED3C@lca.pw>
References: <ff202f9f-4124-7e63-a5fb-ebeb2a263632@linux.alibaba.com>
Cc:     fabecassis@nvidia.com, jhubbard@nvidia.com, mhocko@suse.com,
        cl@linux.com, vbabka@suse.cz, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <ff202f9f-4124-7e63-a5fb-ebeb2a263632@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 5:09 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> As I said the status return value issue is a regression, but the -ENOENT i=
ssue has been there since the syscall was introduced (The visual inspection s=
hows so I didn't actually run test against 2.6.x kernel, but it returns 0 fo=
r >=3D 3.10 at least). It does need further clarification (doc problem or co=
de problem).

The question is why we should care about this change of behavior. It is argu=
ably you are even trying to fix an ambiguous part of the manpage, but instea=
d leave a more obviously one still broken. It is really difficult to underst=
and the logical here.

>=20
> Michal also noticed several inconsistencies when he was reworking move_pag=
es(), and I agree with him that we'd better not touch them without a clear u=
secase.

It could argue that there is no use case to restore the behavior either.


