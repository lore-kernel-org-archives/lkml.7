Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0019EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90212464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FSI80S6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfLETe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:34:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33234 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLETe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:34:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id z3so1764391qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 11:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ohFqpgFuVLwMR/fPnOxHSbjoD2kJwKsGI28iIy8iuZU=;
        b=FSI80S6wt6yqxmdtp9lMdXY3+LYc5UjWTB1vwIsAcXlDyfxSVPz5KQmZN0tZnN/TOT
         vq+PrzHxbrYch3Ux1DjOFE+WkZhecLq4WqrwcV1hXe77TNihVXGM+WSvhZiQ4XeAzhcM
         2zxZxrAE5+Z+XZFziJdXvGBOF7Aw4I2J6ZuLjXQuYIrz/puUMzv4ZIXy0PyiXC2QD1E9
         SGb04g64wzP+imIpkiiDEEOMPvFz24AmgKEuyXdEuklQ0Nt93OH9tdvw88ZoI7JjHISQ
         sD7+bJGg9ya8lxY9ezPzx/X04/x/puxZpNsXs65yfg7uzCy4dbwb220wBVTJmH6CNWAe
         gmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ohFqpgFuVLwMR/fPnOxHSbjoD2kJwKsGI28iIy8iuZU=;
        b=EkF+Q5b00skgb3LommpfopsdWzbFjgo5IjP3r+DpK89e6115uUZftCrU991T9MdF7C
         ISxkGlwA8UaWjdi3Urqg0DYM4AetvXAVMjj0weR7s+xtSxURY/6WSoRceXeLBhPJSyoH
         fjhdkqJEjcnI3HB2GBYnhJecGPMvCZw5B9D3ieOR4CSAkBjuWumcDJBcFLV/gio/4o8y
         C8sBR4rQP+TZ/xYYClJWjqONaBQab2YzVc0kEyOw1N+Ua2ouVA3HH4gofpRj5OTEfaxK
         2BBvlXj1PWVQCowZzfAQMByrrYh6TRfY7loQzynLfyuyXlvuAqH+8idNFhqstfhvNapd
         KyAQ==
X-Gm-Message-State: APjAAAXBZ73iW0s1Htc8M83tIjc12rHYlipnusoydmhPP9feQny8EYxw
        CFcIuhX6rupZS/eQlGelRmTCTg==
X-Google-Smtp-Source: APXvYqykYO+fEIijGOKaoHOo0rjkpKIgKBKPXv5S5alIm7Mz3Z279D2irvJWzPaCU8jHSyK8jDXfFQ==
X-Received: by 2002:a05:6214:245:: with SMTP id k5mr9171653qvt.182.1575574466035;
        Thu, 05 Dec 2019 11:34:26 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u24sm5362334qkm.40.2019.12.05.11.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:34:25 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 14:34:24 -0500
Message-Id: <A5A53ED8-D17C-4BCD-9832-93DB0D9302A0@lca.pw>
References: <d96e3849-5fd4-26c0-31cf-02523085ed37@linux.alibaba.com>
Cc:     fabecassis@nvidia.com, jhubbard@nvidia.com, mhocko@suse.com,
        cl@linux.com, vbabka@suse.cz, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <d96e3849-5fd4-26c0-31cf-02523085ed37@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 2:27 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> John noticed another return value inconsistency between the implementation=
 and the manpage. The manpage says it should return -ENOENT if the page is a=
lready on the target node, but it doesn't. It looks the original code didn't=
 return -ENOENT either, I'm not sure if this is a document issue or not. Any=
way this is another issue, once we confirm it we can fix it later.

No, I think it is important to figure out this in the first place. Otherwise=
, it is pointless to touch this piece of code over and over again, i.e., thi=
s is not another issue but the core of this problem on hand.=
