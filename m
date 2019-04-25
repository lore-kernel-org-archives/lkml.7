Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB910C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD6420717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="H7Bd7bG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDYSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:51:50 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39576 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDYSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:51:49 -0400
Received: by mail-ed1-f43.google.com with SMTP id k45so810902edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b55P2IFv2UpxlgvURrxCcFTUbkVb37FoCTfo/TcEgTE=;
        b=H7Bd7bG1fJeV3A7INUqsw/yC6Tcx2LmSaWfrxZGHChZtX9HVJ7LWkiMwAStQzY1A6C
         e24kQ8YYbrhBrBPegRC0b9Le06WH/iz/3/Tb9vPHtsQSfj/7EC6gZ+JFDVIQQAlBndJo
         NIJQBoajtzB8lRybkTxj5S/QajeNkN6FOkAIsnrct7YcTs9idIKsQd2EZD0LinOY1wPR
         ketwMV/wqOn8l22PoVtns2mz+U6LYkCkn02WCKWghRaCrl1nL+81/ToLl4nmbcTdxoLN
         /medWc+TUcgxQAQvDM7+8Vz9OFaSYGcHjgAa1VBRCMiEYYOVhIQ+mOykud+6mW8u+/SI
         yPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b55P2IFv2UpxlgvURrxCcFTUbkVb37FoCTfo/TcEgTE=;
        b=hZOB5czyFRvfMFhD06jHP5gZ9CmYXNU1R7UilrtiFXM8r6vDucTsA5wfzxSw5eS9VX
         VbnLNTXcmabKFJtKmxAZXooIaT+uzH5QBZJD2OZAb+h3yCRCPhxa2Mw3hUCaxm9Sv9VH
         fwgZpU1dXpa90awRdpZLA694X9BEolcZ2XwQJ2zsNIipCgD68VIVSVkRCTiawtHpz4kI
         L2PSNe+z1V/ecmPJSi4qsMqA5g2UjjOFhv3/Rx16MkKTNOZr6LElpctGrxjKvkuR5YMu
         TF1TsxxdFNLJtcT0fU6imtI3RHaKYv6s1ksCVkvxwqpapALUz/Aa78kTZl5W/9MwCDTz
         3APA==
X-Gm-Message-State: APjAAAWCcrjiQvz1hDK7cGYkg04qD+8GeNVdMkYhYMiBDbHHCewxjqD4
        TlkFzEvcWaHt7drTjhx4+0DNizl+c7RfvzMbUcLmiQ==
X-Google-Smtp-Source: APXvYqxfNCds1kl6313Ad4+cJxM/dXtmhN6kZ83GGVN0OsY6b4YD/uFBtltwpNCLN5C76jVxd/HWZ8/Eth051yXAoBU=
X-Received: by 2002:aa7:cf8f:: with SMTP id z15mr22750446edx.190.1556218307805;
 Thu, 25 Apr 2019 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190425175440.9354-1-pasha.tatashin@soleen.com>
 <20190425175440.9354-2-pasha.tatashin@soleen.com> <67dba1e2-155c-f572-81dd-a6d589d0e8a5@intel.com>
In-Reply-To: <67dba1e2-155c-f572-81dd-a6d589d0e8a5@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Apr 2019 14:51:37 -0400
Message-ID: <CA+CK2bC5G0DrBpHuaV5xrAAZUKHVwN2N++eiV++SH2gvvbKGHA@mail.gmail.com>
Subject: Re: [v3 1/2] device-dax: fix memory and resource leak if hotplug fails
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 2:32 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/25/19 10:54 AM, Pavel Tatashin wrote:
> >       rc = add_memory(numa_node, new_res->start, resource_size(new_res));
> > -     if (rc)
> > +     if (rc) {
> > +             release_resource(new_res);
> > +             kfree(new_res);
> >               return rc;
> > +     }
>
> Looks good to me:
>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>

Thank you Dave.

Pasha
