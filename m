Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="nFhz4TvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfIYPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:33:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41255 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfIYPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:33:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so3483076edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXF8fOz68zu8jSsi2oLIZNjcKNSoQ5Q7ICUWMBhW7DM=;
        b=nFhz4TvKr9xBPUOqvetSHmUbh3EQ9lCExfFxilYXCW6hELd5xrptu0jhKEK25o20EJ
         Gg+aZGbC6Gz3auQyizHzo+v1pDRbzSZjr1eDys1u37dLQaCrZdDdJ7Z0zkaQF6vDrLjU
         Rqvk3/vbAa2BoNNPP5rnqdkP951jp2KtC72hcQN5nt5FnqwwEvmCwCIV1r794Dgcm+sY
         wjeInu9jOq1/8eyq2q4W/yCVWbeCOWtbiByMG+RIeAEvFhOIqJqxZh4I46CGvYENVgsO
         iQ3SXRlCmb9r1A4+GTrR0Wacrn49h/SVnBHVwSV6/h/Sm65vGxPsrAdXBKbChI83A2fx
         tUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXF8fOz68zu8jSsi2oLIZNjcKNSoQ5Q7ICUWMBhW7DM=;
        b=CylY1U5OtDyyxS/mvSXmBwu2ZMp2V989AL5cFdVZdku2cwBSqWh8DX/utfvmCTBJIh
         /e7mjNnz2JTU/L9ZE1EzdTpof0i/OypsXoFA8dPD+BeKgepmpH1MsavQ00tB2IwuXyd0
         E/kn3tYxcX3pXYQdIeIquQsY3uuiBzPZl4yYZ9u/ZIt4W8kByelkVloOjOjNiptvOuET
         Ow4HuQVIWsRdgmpwDGsBN4lSV0nY0zjdoslmKLKRFdyPBABPi7llV2mXvTTANRK8Qsmu
         ZfsjilK7YIeAA/K0TePFxQi+uGLWQDRVD/9Pj/RKCFs+zCHd1/Dm+Hk80KJXo0p/E4gs
         HVYA==
X-Gm-Message-State: APjAAAVn11ZO92h6T8Em6sj6u6829KHgnH1803jwG384wHiq8T45w1Xk
        ii5jco9IapxNP9FLGz96I9ntvSI4yILJrm1rIw5gEA==
X-Google-Smtp-Source: APXvYqxX489cqrkLHt3Qn91y6+7hXWDB8tLdECyqKNPDtfNZ49G/iag+TIVI/SOqZQbaXZn2k9NWW+dNMN7NIGCwum8=
X-Received: by 2002:a05:6402:1ade:: with SMTP id ba30mr3673543edb.304.1569425596583;
 Wed, 25 Sep 2019 08:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
 <20190923203427.294286-2-pasha.tatashin@soleen.com> <20190925060445.GA30921@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190925060445.GA30921@dhcp-128-65.nay.redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 25 Sep 2019 11:33:05 -0400
Message-ID: <CA+CK2bBscWKpQ43jjzaN33wHm5m7W8ZGiW7YCTE+Syzu2ZunoQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/17] kexec: quiet down kexec reboot
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Acked-by: Dave Young <dyoung@redhat.com>

Thank you,
Pasha
