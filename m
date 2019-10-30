Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44041CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA4820873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jbIvggOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJ3VyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:54:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39635 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfJ3VyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:54:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id 15so4543561qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=41dVk3HlaKb/dFjB8UnWPeItSsHUeTbp2B9Q6WI0tdI=;
        b=jbIvggOIeT93+HYPaTBumtry7oeGFtRGRR/RJZ//h55U0bXJOWNKOfcHnZsH8nOSWl
         ijjgihsoEFCZxaBjB/0RnqYBI1yXeuE4KsNREA7rDgbLcUukvlHQ7BiuLh8SnlAIY1Zj
         2teTt4r/7ljvLvpSxEbw21SmAMMe7xfYuqcf+z+bLbkEaCoF5KcFLv+vipKztqVqk2UR
         Fi0fMP14X7hf0Gl/7+UWABKMNrv18W5BFb/b9DVRJLD0CPzz44FiXlPDuwKMfz7KUOZg
         uGZIN1nJUZM0Wxck74k4CocTGv72D/HSth4B9ilouuvO2SdGzq1j3ykuB6nPpkCaeT/l
         n6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=41dVk3HlaKb/dFjB8UnWPeItSsHUeTbp2B9Q6WI0tdI=;
        b=XN61Q7vFRT62Z9xD85amElqQl6c6PD8qks2rBWGxee/E7NmUpHcsItAew7aj80vM8D
         T0p5r3udeFGZb82uWQEUIZjeIaTEtUsX8NPfeHA92zQCuRT30BEobKqBziQEFoggtssw
         34YB+PTFgeCxJjwMmotu8jkjqoshxP5kCyQ1iC6GRwmQcPPcvge+JiwEOsP2Eo3cToVV
         D7RsZyJj+rKcjghQsFl6kX515xOXph2suuslfJ73MLCWLvODeP1VLtLr7uMLoU7D39ZC
         sF950zX6/l1/QMcvy/NhIl8HxaTvbuhgTUDaig1rAzgl8Mn/AHYJs9BdNUhtFVymlXaY
         1Hcg==
X-Gm-Message-State: APjAAAU39sSrxQs50/98vj7lg/wtUjYED93TbGAGapVKLk2zSD16fO+5
        dCKd//OoQwnGcN0d8GztEFwG4w==
X-Google-Smtp-Source: APXvYqwrQ09V/5pkR6XSIY1CNfD1/GGL1Zz/FvP/T6FEFfnzt1OotLdGJngFwNtEvyKl0Z4cQVy96Q==
X-Received: by 2002:a37:4cd5:: with SMTP id z204mr2102084qka.153.1572472447368;
        Wed, 30 Oct 2019 14:54:07 -0700 (PDT)
Received: from ?IPv6:2600:1000:b063:e143:9455:99a5:c2db:fc9c? ([2600:1000:b063:e143:9455:99a5:c2db:fc9c])
        by smtp.gmail.com with ESMTPSA id n62sm769982qkn.47.2019.10.30.14.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:54:06 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Date:   Wed, 30 Oct 2019 17:54:05 -0400
Message-Id: <5E00893B-D36C-446F-9E71-54FB32772DA0@lca.pw>
References: <03cacc16f2fcd7cc74cf15c57070c78e73206e68.camel@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
In-Reply-To: <03cacc16f2fcd7cc74cf15c57070c78e73206e68.camel@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 30, 2019, at 5:38 PM, Verma, Vishal L <vishal.l.verma@intel.com> wr=
ote:
>=20
> Good find! Since we're not really using rc later, we should just
> simplify this to:
>=20
>    if (btt_map_write(...))
>        dev_warn_ratelimited(...)
>    goto out_rtt;

Ah, I thought about printing the rc as well at first, but it seems only retu=
rn -EIO for errors, so I agree with you.=
