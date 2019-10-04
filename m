Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDAAC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1512084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSQIKl7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfJDSYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:24:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40461 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbfJDSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570213479;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqzzV5vJFNCOdzSEIMCqALKm4Kwel64+vdB/ceB/Lkg=;
        b=SSQIKl7cEfo2GH7hUtGP3yMxqY85XoBtslJjfcEUDiy0T7ZjAgCXvPBOt4wVFg6qSLjBXU
        wqBivYu3KvrwhEqeFd9P3hv89EntasjtykKn9W5BimqltIDBjDTYs8u/DlCtAXLph6N6Z5
        etuvcxHoXU4/T1xechKs5/LhbCSlpyc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-W0yWYgqMPM6J-mWxq41ilg-1; Fri, 04 Oct 2019 14:24:37 -0400
Received: by mail-io1-f70.google.com with SMTP id g126so13409138iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pqzzV5vJFNCOdzSEIMCqALKm4Kwel64+vdB/ceB/Lkg=;
        b=Wggr0PMvbfzpP4Y7UKUHnhXeZ5b4YdnlkzgtxrfOXo6Ye+4B2c9haKhos9o2V75x8k
         DHwv20aPulhXVbSE0WyRzyfymsdpTs5MqHlFJerJTwy93eFXLVTxiv8wmEDMn9rltOzg
         x2RhDF/nQXIceBGtZAYyH0q1wq4vIaC+pZbW5kA4RWh3x0MPoPyitQ6REkNVIo7qOYbc
         arJ4MykPwsEtifOQuEsvE7CK1bz5Pvw188jcxlpvzQzwOHVPdGEcsR8Lvc9TazGtkx6T
         k274c8H/qdVd7fp5RAAGgzruBOF/3PFWLIyid+Rt3iYXI+fKrgi9O66UQwZkzYAUo6mi
         h48A==
X-Gm-Message-State: APjAAAUb1eJYsZ4S0b9m4R/PkqklQrJKuHlyPlOPrOxf6WtASz8Rg25e
        u5J8JbQL8QlVX9nMtzJ7XUTOWo9QVYBbPrQUE6gSqwg5dBp7jPcNimGz0N8cec1UHoQdYVAd4na
        1loGfcfNZFYymCPlbDE8pVw1O
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr836991jad.61.1570213476839;
        Fri, 04 Oct 2019 11:24:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyI8fLd6aXkKdblFKVEIM81Q5egEhQo3siRanbIZDP12JwkuVCLyPar9tLUnjAhEGDqfiNp/A==
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr836947jad.61.1570213476540;
        Fri, 04 Oct 2019 11:24:36 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id m9sm2479604ion.65.2019.10.04.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:24:35 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:24:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
Message-ID: <20191004182434.tjwtfjzvamomybhr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
 <1570207062.3563.17.camel@HansenPartnership.com>
 <1570210647.5046.78.camel@linux.ibm.com>
 <1570210902.3563.19.camel@HansenPartnership.com>
MIME-Version: 1.0
In-Reply-To: <1570210902.3563.19.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: W0yWYgqMPM6J-mWxq41ilg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 04 19, James Bottomley wrote:
>On Fri, 2019-10-04 at 13:37 -0400, Mimi Zohar wrote:
>> On Fri, 2019-10-04 at 09:37 -0700, James Bottomley wrote:
>> > On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
>> > > As has been seen recently, binding the buffer allocation and
>> > > tpm_buf
>> > > together is sometimes far from optimal.
>> >
>> > Can you elaborate on this a bit more?  I must have missed the
>> > discussion.
>>
>> Refer to e13cd21ffd50 ("tpm: Wrap the buffer from the caller to
>> tpm_buf in tpm_send()") for the details.
>
>Yes, I get that, but to my mind that calls for moving the
>tpm_init/destroy_buf into the callers of tpm_send (which, for the most
>part, already exist), which means there's no need to separate the buf
>and data lifetimes.
>
>James
>

Sumit has been working on a patchset that does this.  His patchset
converts both the asymmetric keys and trusted keys code to using the
tpm_buf manipulation functions.

