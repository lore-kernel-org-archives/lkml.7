Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEEFC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9202087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdV88kvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfD3U2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:28:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39682 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3U2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:28:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so3741617pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXwghiICh1eldrtSalnqvtotlHEb2et8Ey19xhCS3H0=;
        b=mdV88kvrYudT0nZLfucRabRvuO0EPWDlGrWZgJ96nbG4LKfAgC51KKkrmI14gs87Rq
         R1DiK9TZMAv619dt9QSaPJtQx+tEnsEiAXSrGgvplyY4Cwt7NTwe2PREN0uSAO4JO0W9
         P7K++k8R5hp/FND53+VlCFCPZ07FQrKb9Sqkt2PCIUBF4rnRN9Eu1btvn/RGfDNl2tWS
         MEM/3hlh7SPSUviM8Jnnz3nOOckBbS1VDWiKbqm7+51gfFUV8YnDOSjS5UKicu1retSH
         9CCDaf1UqxsRgT+ON029FHL1IZx9rD7y/nVgzV1HnSVMujNO54T+eU4QllZvV6ZAKAtg
         hPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXwghiICh1eldrtSalnqvtotlHEb2et8Ey19xhCS3H0=;
        b=N26HHcYkqIp0IJfcgUA4amzqXp+35R7zkpM/CjCyhzaLxZphNstjXiUJNQ2ESFP3Ek
         xvwlIB3GpLiVm2UWqsiVeVp7p1CNuE2SjPzlW3T5Byikiht8U3S+nqjQZLkt3UO//5B9
         PzQn8UAi3LXBL3YjSI7i3vtgvh20c2P8e+yDnD6j/V/+JGX0Nui3eP3SMOJ2/9k+O1cL
         EWbttVDGllVlIq/WFWC/VaUYeR//btOuhOFOcfZEbPfv06tAlu81fhL6GJ7xk2S0Mj+j
         L6R4rmLy8Qs4mBz4B5iINc8IXkcRUDXpYa9cCB8NMDLJx58Kn4DSC8lxEku3IoueFsjc
         sDyw==
X-Gm-Message-State: APjAAAXrUp0V47y+G2o7CmBwZq7tbIs/6vgYRWQH9IpVVMAbmM4b0kV4
        6kaxmUYiwTSeeRXSteOX/LplXj10mLo9ytmiL9FHIw==
X-Google-Smtp-Source: APXvYqyNhbvVoO4EjuJFxyBCDSxQDKib5dOhDjIMV3qxW+hQaE5MYK/II1MHlO9cTMehkRigVC31KPEmWP8nYj/4SVU=
X-Received: by 2002:aa7:8096:: with SMTP id v22mr73385240pff.94.1556656098122;
 Tue, 30 Apr 2019 13:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190424185742.7797-1-natechancellor@gmail.com> <20190430091242.GA2269@kadam>
In-Reply-To: <20190430091242.GA2269@kadam>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 13:28:06 -0700
Message-ID: <CAKwvOdnnozOfk2e_8wFq6GALZWcL6qrXFcRMBEkgck8p8TyMbg@mail.gmail.com>
Subject: Re: [PATCH] staging: kpc2000: Use memset to initialize resources
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 2:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Also it was risky from a process perspective to delete the stray tab
> from the next line because some one could have argued that it was
> unrelated or that the whole line should be removed instead.  You would
> have had to redo the patch for something silly... #YOLO #LivingOnTheEdge

Future patches to Dan shall contain the hashtag #YOLO.
-- 
Thanks,
~Nick Desaulniers
