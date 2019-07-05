Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C3C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88DE218C9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh6G9QxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfGENj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:39:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfGENj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:39:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so4348984pgl.2;
        Fri, 05 Jul 2019 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yz/bvXxfkDYqJoVFft3aC1vVTiMIeTWz1wlVELmSGYQ=;
        b=Kh6G9QxSOQPflRqPMW3xsfPNqflJLlV0SWqmKw3ii2M4XMDwfbCD5fGl/ryOMj7bpq
         cDcKcB39t8nsxr/eJeoxTU4YXhaQnkfQZHb14mcyAxjpXaMSBahlof31ZonHhSZ40NPk
         Ftfnj3/OlRjMN1HRNEvGRzORywGU8owZ0nG6zrFDPiXhacpZDD44hwY89bLBMuBFHIJi
         5D0SKKqAICvhT/WpDstuV1/+1bQqI5x+hisWHSFuvyJdyyhV4j7eJNyRIg+KoA3mPXNp
         aOhw2e68JnxXXePgqe9+pVxS/RhkbLXvypLGnIhWdNh/+w0j2DQ272lJoX3Aszeu6uu8
         T6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yz/bvXxfkDYqJoVFft3aC1vVTiMIeTWz1wlVELmSGYQ=;
        b=NqLl6EYB2D4Uo3ufpHNLJcjpPH5ba0skgmsSzuIoje/276MVF5KYlSQ+5tUL4ULACx
         OVyQ2uR4ZhOrhKi/p93n7+4ADd0DUZlOFCA3IDfg43Eczpikn0WSMQ3adruf+t+7qQFH
         ji40d/I4A0qbzgizWJmj23AwSqQmSI/dqZaUVxuwdDZoZiYJftNCLTYJ1OJLoLLJUobM
         2VSjlqtV9QmUkp9B/z7r4QHweho6K00laSgcHoxPqNoKXcm5yJx7toC6QA5G2o/lVaJX
         X5apghF88BAY+Yfkf/JgFXYOBtANWpZkPqhnUKp+YvX0kK9ea8onPnkZHtXefJE/eklj
         zIpw==
X-Gm-Message-State: APjAAAUNilD8vFlrQPCLzOhwY95igSIaCD9gKfQOyt1XhoX2frle5FNK
        6awSBjOJPJO0/jVQHkb8iTs=
X-Google-Smtp-Source: APXvYqyRcWrfurmLqtOm81P0n5PYS395MdcibqcOdy+Y59FXFo4mkF7bmglv+2to5uKrUa1fFZH+bA==
X-Received: by 2002:a65:6406:: with SMTP id a6mr5494274pgv.393.1562333994885;
        Fri, 05 Jul 2019 06:39:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4580:b719:ac8c:5fbe:1262:33d4? ([2601:647:4580:b719:ac8c:5fbe:1262:33d4])
        by smtp.gmail.com with ESMTPSA id v10sm9676088pfe.163.2019.07.05.06.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:39:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] KVM: LAPIC: ARBPRI is a reserved register for x2APIC
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1562328872-27659-1-git-send-email-pbonzini@redhat.com>
Date:   Fri, 5 Jul 2019 06:37:30 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2624F5BF-1601-4A7B-8CA2-7D3328184E46@gmail.com>
References: <1562328872-27659-1-git-send-email-pbonzini@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 5, 2019, at 5:14 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> kvm-unit-tests were adjusted to match bare metal behavior, but KVM
> itself was not doing what bare metal does; fix that.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reported-by ?
