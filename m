Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA5BCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2557420820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ISt0Da+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502940AbfJRSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:25:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33571 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502886AbfJRSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:25:22 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so8616491ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DDu/IAHCCoDYbrGWQJqHqgeQldPkoq1jl8KIeufJyiA=;
        b=ISt0Da+OAsAtGt6QgzzKN5nThCoXEDZS6clnnScRtibWElaDsD/W4RTTNQ6acbpK/j
         l95KMPu72vxXKr5UWzk4mDrPZKzMAmOFcRw3lJHfjIPeuHfXoLL5QdHQT2tusEOllbyI
         d6ktFHxCNpFnl9myg4QWttqBICnHFvxFXLeVBMrbb7orBISgGFce/9Fxwto1lnNtCWYD
         M5hBUSGFFn/Ntm1HMvUj0LdPYBi6FYVBUTigi0z3tnpxbBRl9gdb4MtOIf+KUEc9eEci
         VxKJZqtwDRshEl/N2path8RwlSv2JqdGaPkkPjw7PeaXXOsE4Eqg7odxoJKsQyWd6+DO
         RQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DDu/IAHCCoDYbrGWQJqHqgeQldPkoq1jl8KIeufJyiA=;
        b=sOKNS0YS0vx3BdIKSxn5IV+cNQo7Crr6Nx+POSRQyIszlogr2lRyc+EAK2EHNCD0Py
         nO8oW20R4p9BBAwN7hsKc/1HYTs8sCzQH3MH/MHY6zBiHp0xNeUCF1l9O4qmFaCzjW0T
         +0lBS+bwn4j6YelG4/9gveCIcYRAaidBTeGc+OUzsT1jBRRtEj8fq0hKGsdlRHVlphFT
         vSGLlT9ahQCSOaoyGCcXaQI/gJvZXLYkSYUo2b3XpRVlpW3Oft15M8EzXMFb4rNDOAkQ
         w5lVdEuI8JadUl1fMZyyzqgeJPG5VBcXX8t8yA3QYjIcUlLCTxvObckA07cmA8ziDrF0
         8Pkw==
X-Gm-Message-State: APjAAAUrEQ/62CdNGqNqY/fPFQ32l2FiUws0asVHspGoymBGC4D3L80R
        BBHWz/WbeWdwNXrH1lWketSRZw==
X-Google-Smtp-Source: APXvYqwFm8QnDjxMk1Ii/z0SeFVjpCdpbt8QkXM1VvTvVcOykUolmscleqfMpc4W6WEofHqEK2BJ8Q==
X-Received: by 2002:a5d:9057:: with SMTP id v23mr3972088ioq.119.1571423121834;
        Fri, 18 Oct 2019 11:25:21 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id c8sm2044407iol.57.2019.10.18.11.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:25:21 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:25:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <Atish.Patra@wdc.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>
Subject: Re: [PATCH v2  2/2] RISC-V: Consolidate isa correctness check
In-Reply-To: <a45f0c0e3db2e852770485bc581d489b6ee7545e.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910181121270.21875@viisi.sifive.com>
References: <20191009220058.24964-1-atish.patra@wdc.com>  <20191009220058.24964-3-atish.patra@wdc.com>  <alpine.DEB.2.21.9999.1910180142460.21875@viisi.sifive.com> <a45f0c0e3db2e852770485bc581d489b6ee7545e.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Atish Patra wrote:

> On Fri, 2019-10-18 at 01:43 -0700, Paul Walmsley wrote:
> > On Wed, 9 Oct 2019, Atish Patra wrote:
> > 
> > > Currently, isa string is read and checked for correctness at 
> > > multiple places.
> > > 
> > > Consolidate them into one function and use it only during early 
> > > bootup. In case of a incorrect isa string, the cpu shouldn't boot at 
> > > all.
> > > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > 
> > Looks like riscv_read_check_isa() is called twice for each hart.  Is 
> > there any way to call it only once per hart?
> > 
> 
> I had to add the check in riscv_fill_hwcap() because that function is
> iterating over all cpu nodes to set the hwcap. Thus, some of the harts
> that are not available due to incorrect isa string can affect hwcap.
> 
> We can check cpu_possible_mask to figure out the harts with invalid isa
> strings but that will perform poorly as RISC-V have more harts in
> future.

How about just calling riscv_read_check_isa() once for all harts and 
leaving riscv_fill_hwcap() the way it was?  You'll probably need to hoist 
the earlier call out of setup_smp(), so it still is called when 
!CONFIG_SMP.


- Paul
