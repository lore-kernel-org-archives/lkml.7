Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2969ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C721D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LuF/o/Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfJKLHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:07:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40782 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:07:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so8468630qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fhRFmkHyAxoggsqD4KnxC3QDzsYkibgJooXeMf6to+g=;
        b=LuF/o/OotnzHUK7u//h5FxCIivoOI1UcqVDmEJc+VucVnEfMsq7uIGsE5qS9GSqnjV
         lCTVQBnPMNdbT1GxpAIsToXKYMZwDSrLKNJXM8pEM3JKM8VBZqo4175fiedNPYXy+8wk
         mS6P5kXgvYi6uoLSYC9U3RUba0bM+gCqAN6i8EmtfNp+b1x16vj90EPrbUmk2WARWwt9
         4pV3fPd4RhlwQ/Dsida87/VGb6WfNqBszt56gQ5YNcqSHIGlR2Yw/+bloaRTlp5aYTbU
         Z+4uEdoT5xIZvyJ/FdBW1YJaLrowOqV29YOcnMvuAy1sLUjhFIC1YzVircFa5pQeHujv
         j0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fhRFmkHyAxoggsqD4KnxC3QDzsYkibgJooXeMf6to+g=;
        b=Q7E9h4pVWqARd5nPN/R7l6XtFPOCQN8H6WuO9xbIsMcMWhpK1V6GG1FCESE4ymOKtr
         kFPXBdNGQDb92qRFTd5R85KNmkjozFXdzuKbYp077iztfKHjVBt+HBa+6eX1oPTnNBlx
         AoZonf0Hi21Fo3L2HypnUCT+dCqaKnU9WgvjAaqhARRNsjMlLSD2nloj7j/aLYpXivta
         QSo8iFtF/52mLyj1RfoAWERt6XqOuGeRK/MhCMTnpzZH2VAY8Ya3bdHTYS5VovC/R/la
         tOwhO1sa4bSatV5m43JUfuK5qmSxSdxtU3ANKv9+XIumvqeDfBXy/DrUYuh4rvQZpOgB
         je3Q==
X-Gm-Message-State: APjAAAVuEvq/XC5xRNhE9+k39Y8w/XQczdD//sWUoQZ1LjvkzsjfOWLF
        UE05oGULMIH9EQfYuhH7f0+Y2g==
X-Google-Smtp-Source: APXvYqwf26+beDRiEznayQ9n1JDIBxpwPJNF1cRZSuh9K01KYUk4RZUYpdSAydkHfTPC7Z+HVii53g==
X-Received: by 2002:a37:4553:: with SMTP id s80mr848341qka.334.1570792055855;
        Fri, 11 Oct 2019 04:07:35 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k2sm3893462qti.24.2019.10.11.04.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 04:07:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: fix a crash after memory offline
Date:   Fri, 11 Oct 2019 07:07:34 -0400
Message-Id: <668C1E6F-C119-4BFB-9B9E-7E5568453855@lca.pw>
References: <dbf95ea6-fe44-41c5-7f5a-a780e5ff42ba@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "mhocko@suse.com" <mhocko@suse.com>
In-Reply-To: <dbf95ea6-fe44-41c5-7f5a-a780e5ff42ba@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A860)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2019, at 5:57 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> You mean, I found the key to an unlimited amount of undetected BUGs, so I s=
hould fix them? ;)

No, it is more of for the sake of consistency, and the fact that all those b=
ugs are only starting to show up only recently after applied to your series,=
 so you will probably explain for a better changelog why that fact is not im=
portant.

>=20
> In case you don't have time to explore all the dirty details, I can take i=
t from here. Just let me know.

Indeed, I will appreciate that if I don=E2=80=99t need to dig all those dirt=
y details again myself.=
