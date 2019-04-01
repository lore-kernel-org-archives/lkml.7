Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D7EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2640720857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="g+JRh6/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDAUpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:45:40 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38601 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfDAUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:45:40 -0400
Received: by mail-pl1-f175.google.com with SMTP id g37so5064274plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZ34b0B1GYi0tgWrDIATuw87bWrj6Cc1yyDNDTdEAw8=;
        b=g+JRh6/9x7QV4GsRQzMo4oKRgIeYtlcvXNuzSlmUGs+hi/l7g8AA+U+6IPPAIODSmr
         BsMzj23+G1shcEvyY4N/2CXgIW/OPTFpppQdAwDMo7EeNnNIvl8NWnwPmvn+Pl6YqAbe
         QiIdtXS2Q2WlmRcmllatwUBpxAgvh7xMv2egNAHOJUT4ll7OglIp7YzYCrOSTPYNVXPk
         ockfZ4wmbLDVHWV5P3p+3Ta4/dRTrTwjd5swL3ZJ8F/fzb8HzTRNmhGCSrDlQI//U2HH
         1kO4Cb6flgvYaR9hPyrFPIgK4Ov6wG42r1zyGc6MpJ79bBsk/pvIOsbNCayLwURoIqYH
         bTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZ34b0B1GYi0tgWrDIATuw87bWrj6Cc1yyDNDTdEAw8=;
        b=KoU88kmxFML74b7sCcbs3sxtzvCONcweKOzeykHbubDbpXJJbU3MuGdFAHGLwS5CeX
         AR++bkxfjf0dcTXpy0IT4k2QzgAQiy584DE+BdKpsuSFXSD9yTHnrrlclwV5wUAzMlDs
         KyZ7xmEaqBUx9Dwh05A3VV2VYllHzGxcrlhH88p6pf5gM98OUPgjw5/QAt5xymZX0/OT
         Pvho0NOYa7Yt5l8tww1mGG2C8lBZnPBYBGkhUZyu3tGsRZgsYakp3F64TZKRGyUMuyQM
         MMvjIZ2KTdEGFc37PywzZdy/PCRXqRVUOpgt5NmVQ7vsfI6SS1Vjvm5BFUnz1RDWuNzq
         8giw==
X-Gm-Message-State: APjAAAVTJTW+yqyEvBMzECJx0ZNFniELFw9NvW+NYOSRJ8UzDmPkXChp
        4e7PqUXniWdXlRJ9ZUkKHNH6waFV2V5Cirk9zgEN7w==
X-Google-Smtp-Source: APXvYqxtlqdJS24yI9pyYHNiNrSTAaHO3WaIZWRswhaf/0pPkOBeNOJJMRDQg67af/jksBmhtspLWXH9msBeonRdg0g=
X-Received: by 2002:a17:902:1a9:: with SMTP id b38mr66099071plb.37.1554151539052;
 Mon, 01 Apr 2019 13:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=VMJ5vK9aXcZ7AgC7f_dx+5ebKgwz68mV3=m6pOA_syA@mail.gmail.com>
 <20190401201607.ruzxt33qbxxn56ic@breakpoint.cc>
In-Reply-To: <20190401201607.ruzxt33qbxxn56ic@breakpoint.cc>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Tue, 2 Apr 2019 02:15:02 +0530
Message-ID: <CAG=yYw=oZFeQDWZkxyZuGYWzyw8eMkzSKVcKYj_XD7vj=E8L0A@mail.gmail.com>
Subject: Re: about selftests/netfilter test related issue
To:     Florian Westphal <fw@strlen.de>
Cc:     Shuah Khan <shuah@kernel.org>, pablo@netfilter.org,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

let me also work on that too. anyway thanks

On Tue, Apr 2, 2019 at 1:46 AM Florian Westphal <fw@strlen.de> wrote:
>
> Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in> wrote:
> > Error: Unknown device type.
>
> Feel free to send a patch that makes it display a more reasonable
> exit+error here.



-- 
software engineer
rajagiri school of engineering and technology
