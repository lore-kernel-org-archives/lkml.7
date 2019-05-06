Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8FCC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557169320;
	bh=bkArkXPBAuOxfE/DGsVywwWsmHffm6VuhXiKlTiqmfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ryrH6y51u+266qY4nD6lDRGr1YrRxUTmMvtM0q22lxzpgxd2I4iZiskNAikE56xQg
	 xdd+gv5V9fRPq21D5IksP/dg9gi9krOv3vANlIYd6gzo+YqMarOvnFNDAWf1yW+IJt
	 2mCAgfj4oYOe3lo2O8G+aAL0BzmdqG5xOyyr3Vvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEFTB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:01:59 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:35334 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfEFTB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:01:58 -0400
Received: by mail-it1-f170.google.com with SMTP id l140so21669058itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNrYOFBuOphi+mBs3VSCY4wajSxNOE2btnBCevj2sfE=;
        b=Gb2RLpd6aGmJwcl4kHm/oOOG5vHh3j5g+c3TBma1DPOqZV5/SdUhfl3cAT4tvWLmb4
         x8tmlD9sW/6letOAiHU5HQc/aU05XhUcxYrEqxIcWAO5la+cds5aO2Llne8pqp+S5ora
         fnfAldz671WumOHU6a93KaLfzLI8MIqcpBE+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNrYOFBuOphi+mBs3VSCY4wajSxNOE2btnBCevj2sfE=;
        b=IYmbdowl9EkEQcp50Hg69xGXjIjO1IeLTy4RPR6nb5RpHXIU3mYB0RGvb9bgoWTU0c
         yatAqP2QpmmgbLjmFFYaexZ7z8PAHAHG+o2LkJXn/XAgemv5rDlh9RQtIWFNaUxgKZ7T
         NBg4oAsWYene4pgkms/2FBdKnDjvNCuhO+F3pE6CsbJe/f+PYbOnw6wR2e9nMljEClAO
         +7MoMQ90uHCSIZXl39HOsfG114rx6SfTOO7S625/Uz77sczrdGmsn2yVCubJFuoRBrtg
         dFd84DWy6u/OTGyryLdGFNCFPKwFnQ66lpIADxAm7r2Ykjx3vETE7haQJTm9suLhzvpb
         YF1Q==
X-Gm-Message-State: APjAAAWxUC/RKBKNjlEH3afK+BlcLZjDzcwgIasc13zk8+Jybn885su3
        ylgIQ3uJwMteCqNTEQUhdYndE06pzcgVGjmIfwGDQ0H2dDQ=
X-Google-Smtp-Source: APXvYqyCAW0wcOcqCteadBtbfWvZ7DLENXXDxX7l2udWc6idAoHR9OZjxUNSthdWykaz/WYfBwhF+sEiexKhTJZhNq8=
X-Received: by 2002:a02:a394:: with SMTP id y20mr19808316jak.96.1557169318124;
 Mon, 06 May 2019 12:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk>
In-Reply-To: <20190506143301.GU14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 12:01:44 -0700
Message-ID: <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,
 gmail once again hates your emails. Your email ends up as spam, due to

    dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

but it has a DKIM signature for sirena.org.uk:

    DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
d=sirena.org.uk; ...

Hmm?

                Linus
