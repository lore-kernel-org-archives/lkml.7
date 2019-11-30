Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA34C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 00:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41BE2464E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 00:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejl5Rgqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfK3ANB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 19:13:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727130AbfK3ANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 19:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575072779;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKbyuOkS3PW2MGMOCeB8esOqQ/aSq2T37sj0B9rPVCA=;
        b=ejl5RgqcNjfqWdj3fof0mggB5SPS7cbM/Ajxtk90O991Krj3csn35jl244KvfRz3qewVpp
        r5SbuScAozBAwtp7lfCBmu0GWl8H+3dGT6WDOYBY3m0JbSKnArh2vEl7UBbF8R2uRbco/5
        IQkY98x8Nd9klwEhxtHt0jsM+H+tvUg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-CvXHSUssM6KVYE0hlVRT8w-1; Fri, 29 Nov 2019 19:12:57 -0500
Received: by mail-pj1-f71.google.com with SMTP id m12so15544059pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 16:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=H5rAN0lVb9RDPiR1/dzryPNeMEEOLBOdHyVpcyv58Ps=;
        b=fol4/TVSwe13KaufRw1QqpBjhzTKzbgcrEgrpt20UEPo3L7L7SCCK1S6v4v8G6EuV3
         3xcVXHM8aCG4eMPnoEFZUn74YJxIgWuuNYoNEOYmVF2p+/4/eaqP6UzTa5q4QzaOqPrf
         3EuY5wkFfCsTMcNmjAo9DJ9esYFTrW9UJxtrNtwPrq8I8LT22Jz4bwL9ULMXUWuxX8z+
         CpnZ3Ax+jlKxFrs5GlQb2CGbR3XauffdM+ak/usz70pCE55dyqbvd/xlnzv3SuDXCtUa
         qI98Ol5nZJyNday3eODF+Ej8MmyvQSqbfLHxM9NXcIn60rncmJJMxBWAAsZahf4+VGy4
         SEcQ==
X-Gm-Message-State: APjAAAXBQfS9/hnrZxsrmMfphffB8wYkJXnmyYjH9m7cyIIfWHks8nP+
        cB/YBmL6ug0UgItaMXcgV4iu7v4B8pKnCeYssjDvCYvnpxeosYVc4DjgxQMcVjgKV8Yn3lFZlv+
        Plx8cJaaz0I1z2UyN79iH5OGm
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr16707427plq.295.1575072776009;
        Fri, 29 Nov 2019 16:12:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMwyPTp0Icx4kxymsXV5XAdBQ+nWGUPwk3u+Z2NJVehlr1bkBur/T2EmX4WPTg2gVS98kU8A==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr16707389plq.295.1575072775364;
        Fri, 29 Nov 2019 16:12:55 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q6sm13863724pfl.140.2019.11.29.16.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 16:12:54 -0800 (PST)
Date:   Fri, 29 Nov 2019 17:12:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.4
Message-ID: <20191130001253.rtovohtfbg25uifm@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>
References: <20190902143121.pjnykevzlajlcrh6@linux.intel.com>
 <CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com>
 <20191127205800.GA14290@linux.intel.com>
 <20191127205912.GB14290@linux.intel.com>
 <20191128012055.f3a6gq7bjpvuierx@cantor>
 <20191129235322.GB21546@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191129235322.GB21546@linux.intel.com>
X-MC-Unique: CvXHSUssM6KVYE0hlVRT8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 30 19, Jarkko Sakkinen wrote:
>On Wed, Nov 27, 2019 at 06:20:55PM -0700, Jerry Snitselaar wrote:
>> There also was that other issue reported on the list about
>> tpm_tis_core_init failing when calling tpm_get_timeouts due to the
>> power gating changes.
>
>Please add a (lore.ko) link for reference to this thread.
>
>/Jarkko
>

https://lore.kernel.org/linux-integrity/a60dadce-3650-44ce-8785-2f737ab9b99=
3@www.fastmail.com/

