Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B929821835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aBPRZsH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLQMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:48:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43331 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfLQMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:48:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so1895691qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=wzOsaTy37YVhJkswFmGvk92S/B8MsC+ITE+1Iqoh25g=;
        b=aBPRZsH/Sfs64AE3u3kW7ANtwYNQ2c4YQLMRAMI+8xHtmk/fnyElNYBvbVIskkwtpq
         EBM0fihWBDRlg8o2yR/qSymZa36IyZUnDRzR2YjEE1kVwz/MaMnHbzfVhEDFsHWAPvBC
         yaRfeDe7cvrYnwFOFR5TuAjiQGV4ojCOvboNoMic/ypR/5bhPo1uAYSoN00YqNJEQmGE
         6ty7tArXC4tfhO8XGoVD+Gej4hC8vHw7A5R0reslUTXXyK/xarPIZyda5+sGt07JaqsP
         Ny9vv1ERG8OAxqnhSRmlk+x/IZLTzZ8qfWngWnq1Tsf/lMYy0cfQxoHIwlb2n+Dp8VWX
         rsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wzOsaTy37YVhJkswFmGvk92S/B8MsC+ITE+1Iqoh25g=;
        b=aKNgfTN9smroQ8VpMnMSI69+YhuhhAsfcIq4oMPrV6SupshMYhjhpPrMbDEFQa6IRy
         1i3sELNqVisEv1J2DpO/HFcupn3q1ks30KEKO/U2+SWIYFSnPmGPNtvf4iDPW1PXttwA
         IQUfFNrbuDwwhOg/XeptD1pmOYa7QsYLH1bbU7swZmvxl9MpPGwCTLNqecx7+sgp4tKw
         N3qRd0iF4sQERaISLkH4993OiJW+WkoWBzb76U6eL31JlCZbq3lQ4jQFqc/J6ZKJbwNu
         nC6jmB+D9bi3+HJmQ606MNczniJlq91dqNrX/U020nf4NlWiqO5xVe9RtFK7LGPZcFjY
         A8xA==
X-Gm-Message-State: APjAAAX4d6cfCOAvi8oDGnEUn0ffOVWiHSgBz009oNkTrczTQxuGRHot
        xRZBycejM6YEEYFKJj3QiYUuuHTNKag=
X-Google-Smtp-Source: APXvYqwHTaCyhbqwJUYKrw0ZZj/f2bj/1jLWa3eyB/i5hKwSCtnzziH/aCeNS4Svx/9f5aXlXC34XQ==
X-Received: by 2002:a05:620a:1472:: with SMTP id j18mr4911093qkl.184.1576586891494;
        Tue, 17 Dec 2019 04:48:11 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y18sm7017250qki.0.2019.12.17.04.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 04:48:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: remove dead code totalram_pages_set()
Date:   Tue, 17 Dec 2019 07:48:09 -0500
Message-Id: <8456A27B-5F32-4BED-B826-27B17E87AA81@lca.pw>
References: <20191217064401.18047-1-richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217064401.18047-1-richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 1:44 AM, Wei Yang <richardw.yang@linux.intel.com> wrot=
e:
>=20
> No one use totalram_pages_set(), just remote it.

It is unlikely that this is unintentional, but can you figure out which comm=
it removed the last caller just in case?=
