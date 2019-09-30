Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338AFC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC481206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 11:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o21ctz8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfI3LW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 07:22:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34969 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfI3LWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:22:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so7393988qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5ieeuojKyDrT/avxGciERxdoQctNqsxjZK9jSrXbbU8=;
        b=o21ctz8b1I6tslPzChmXHPcBpcpFJyKpe0/lmmhyvLVcb7UwzGkfXGjhrDua9V3gh1
         FYP4yFVpy7iAz80D3V0cVBYf//2m41ycWVHzn4/FsCCzMVJBt0oJej1YYfshIJVwNO7X
         hNPppzmULBrqLtuOvsEo/s0JT6sMqB0EM2NFp59tZCq1zi/lGR3AajZuXQY0ZU1bJZTR
         CRDnaLF8wb4q70545d4woEd4SAO+5G5oMt3XbGRsjnBKvEmBFp8YdUanbzPTfdrccIFO
         CZufxIBlMZ83ix7mSgO5S0QS8O/pQokkHeD9LtQ6GrB3VZp+rekTzhHZvBXCYk+qSeiN
         kbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5ieeuojKyDrT/avxGciERxdoQctNqsxjZK9jSrXbbU8=;
        b=EsdfFnME5Wod8zmeoLBMOSIJ6OBaiuO9Tq1TbUTJ5JQe/6/AHagSefQTqfi5aeZ5ra
         vT74b9Hud8VowvKLwsLkq9Clj5sdOTpg8LhjzLFtLCKidnaK3xdYqYI8U4tMwWwOTfMP
         3iptLRxYkjEsyim/VN2xPQC+XjWPDP8jeXPCzTpo5/hx13Uxg+dl25Nrx1+hN4hIM6kr
         pmi0aNhjrHi2bijEIMSSb+29/es+epiVRV7MXZHYEMMsTdwmc6pOOY/bWbdLwU6HJDIy
         c1b/UhqmwI0tJ3GNg/TC2iR9kA/9qk1F8aMCNt98P/dlVEB9yhPLMYhBV5vG+9rG+RHa
         OcEw==
X-Gm-Message-State: APjAAAUw1UHO+nXpy0/hUb5G7whx/WOxv3aefQ9BW510f3jglaBS11W1
        35/i70tpLjZgkdmVJpocOXL/VC5iQAgtRg==
X-Google-Smtp-Source: APXvYqxoPO0skZH0OTWAmoBjaSWxJOhCffjiIqOU9RQez6VGdZLVY2y9xSrKx+sHcRNhjZHF+RjOZA==
X-Received: by 2002:a37:883:: with SMTP id 125mr18022177qki.478.1569842544489;
        Mon, 30 Sep 2019 04:22:24 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p199sm5506182qke.18.2019.09.30.04.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 04:22:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Date:   Mon, 30 Sep 2019 07:22:23 -0400
Message-Id: <A5AEF8D5-C44F-406C-BCAA-79F32AA41219@lca.pw>
References: <20190930110434.5k47w7xfvkjcohkp@box>
Cc:     akpm@linux-foundation.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190930110434.5k47w7xfvkjcohkp@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 30, 2019, at 7:04 AM, Kirill A. Shutemov <kirill@shutemov.name> wro=
te:
>=20
> Looks like Power also uses the hook. Have you check that this patch will
> not affect Power?

Yes, I did. Although I did only test radix memory which seems just return im=
mediately in arch_free_page(), I code-review the non-radix memory path and d=
id not find anything suspicious. However, if really needed, I could test has=
h memory config or adding powerpc developers to double-check.=
