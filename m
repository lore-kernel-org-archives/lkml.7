Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAE7217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XElxIcOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfFMRn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:43:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39385 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFMRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:43:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so32386470edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbVzXUK1NN9/sw3hoYhD1GHtUrylzXfXjiAM/J+Brog=;
        b=XElxIcOXlFiOTxVzejT8v77VQGmn+wziJUEUa7uBdTmVPB3GQlqrq/i+WZ+W0yfxMJ
         AGWTCUBjBFVbjgKFTlcQbGcOsdU6UlVBEIbkhv2PqCPR0QTVNlQH3HGOWsft/lF9avoJ
         yVjk3wpVIuCOyimIPxq8XjoUi73mZirgNIWY4GkTsEiN98x+RF+PCqlqPZts5nG+ZY0Z
         Lidzym2SV0+4oYyVAGoEBGYstsP1m/t55omoaXEsvzTQx8WJN3mGHuWytvioC4Ht008N
         vPv9yQ4yP4re4lDf999mFYZKd8UbkkzdBZGvJsm59K4MByM2HkTud5FoYxkBWog03a8/
         H3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbVzXUK1NN9/sw3hoYhD1GHtUrylzXfXjiAM/J+Brog=;
        b=Ty9C+zVeNNMcLg3Npgn1r5y03JDQb5rmJGCvByGuK1Sdx3plMa/pkLRQzzlDhmtGdy
         yeZdv9q8e5BDhjO2hbWVeYzZqc8MCiNdbzwLSdQJ2z9w/hSrfJkZdrLgRn280JScPw5H
         PiM6Sg6VdI1AQZRbT9eYiRAfD9T7b5un55N0Da+8mVuq6iMe/DeKEJcJDf2hVApdqyaW
         /D9Pu7QnE6wkcwqLDZyG3ccT+uI783kVlEPlDf6c4O8TuRsqeHSDAxYYXmeWqwIw89R4
         thxQ2XABU4p+EmCY64wL0Oe40oke201c17XragphTddmW/x5X/Id5P7/ooZpvo4D3snY
         M9NA==
X-Gm-Message-State: APjAAAX13/5KNyAFsTDdal9jmEoYqRAaIbBZb8YVn1BdZKP3+eQVmAFB
        aLbBvKrCCIVNsl9aiztqEMq1ttoQaoHDuBvkBZXDFw==
X-Google-Smtp-Source: APXvYqyRkSAfTZEud2sjuEwtrMVjDlLXDnzhlBc4qjCpsFxZK+M8/SJe5pp8MJlhR6sctwLybD1Hs3XKTXr+1omkhdU=
X-Received: by 2002:a17:906:9705:: with SMTP id k5mr43469018ejx.5.1560447803686;
 Thu, 13 Jun 2019 10:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyeoRWfPNmaWY6Lifdkdj3KPPM654vzDO+s3oduEMCJP+Asow@mail.gmail.com>
 <5CEC9667.30100@intel.com> <CAOyeoRWhfyuuYdguE6Wrzd7GOdow9qRE4MZ4OKkMc5cdhDT53g@mail.gmail.com>
 <5CEE3AC4.3020904@intel.com> <CAOyeoRW85jV=TW_xwSj0ZYwPj_L+G9wu+QPGEF3nBmPbWGX4_g@mail.gmail.com>
 <5CF07D37.9090805@intel.com> <CAOyeoRXWQaVYZSVL_LTTdAwJOEr+eCzhp1=_JcOX3i6_CJiD_g@mail.gmail.com>
 <5CF2599B.3030001@intel.com> <CAOyeoRWuHyhoy6NB=O+ekQMhBFngozKoanWzArxgBk4DH2hdtg@mail.gmail.com>
 <5CF5F6AE.90706@intel.com> <CAOyeoRW5wx0F=9B24h29KkhUrbaORXVSoJufb4d-XzKiAsz+NQ@mail.gmail.com>
 <CAEU=KTHsVmrAHXUKdHu_OwcrZoy-hgV7pk4UymtchGE5bGdUGA@mail.gmail.com>
 <CAOyeoRXFAQNNWRiHNtK3n17V0owBVNyKdv75xjt08Q_pC+XOXg@mail.gmail.com> <5CF8C272.7050808@intel.com>
In-Reply-To: <5CF8C272.7050808@intel.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Thu, 13 Jun 2019 10:43:12 -0700
Message-ID: <CAOyeoRXPFgzthfO-Yz7L7ShO=jdYdsD7_UFPOrRFBtdA5jpf6A@mail.gmail.com>
Subject: Re: [PATCH v1] KVM: x86: PMU Whitelist
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Cfir Cohen <cfir@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we aren't using QEMU, I don't have those patches ready yet, but
I can work on them if you want to review them at the same time as this
patch. The architectural events (minus the LLC events) are probably a
reasonable starting point for the whitelist.

Eric


On Thu, Jun 6, 2019 at 12:31 AM Wei Wang <wei.w.wang@intel.com> wrote:
>
> On 06/06/2019 05:35 AM, Eric Hankland wrote:
> >>> Right - I'm aware there are other ways of detecting this - it's still
> >>> a class of events that some people don't want to surface. I'll ask if
> >>> there are any better examples.
> > I asked and it sounds like we are treating all events as potentially
> > insecure until they've been reviewed. If Intel were to publish
> > official (reasonably substantiated) guidance stating that the PMU is
> > secure, then I think we'd be happy without such a safeguard in place,
> > but short of that I think we want to err on the side of caution.
> >
>
> I'm not aware of any vendors who'd published statements like that.
>
> Anyway, are you ready to share your QEMU patches or the events you want
> to be on the whitelists?
>
>
> Best,
> Wei
