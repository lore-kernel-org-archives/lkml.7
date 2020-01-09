Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327C32077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5WrVbYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgAIWRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:17:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56578 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbgAIWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578608233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNdhyzOeLVi3WoKic6P82W86k4Iy9Vwc7SGXsxI3f0c=;
        b=h5WrVbYN/OwGiigKoqs55QbnuakjaoxkSWkuzhv823tTJVzsZI8AseTZHbO+RZ6dwRo+CW
        XFs2Z2Q0pMpVbLSDCzJ7gxlVcpIS1TtV8IFGFPBWtdzH/s1IvRcdvP8i2cW2vb9/RjO+tY
        lzpkbBW1wysV7fLZyN0YNre1Zo0UWdg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-PgJfqZcsMHCTAxwaKM-_1w-1; Thu, 09 Jan 2020 17:17:12 -0500
X-MC-Unique: PgJfqZcsMHCTAxwaKM-_1w-1
Received: by mail-wr1-f71.google.com with SMTP id u18so3422540wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cNdhyzOeLVi3WoKic6P82W86k4Iy9Vwc7SGXsxI3f0c=;
        b=t6nm4jkg9ajNB6dkeDEsAsqO9qkWlv0uIao84ebERH2iHYqI01hbOtSzE/jlmmUmNU
         ccK98zahg7o8USqXjciVnA7FPSNC6pLi+kuBNF6+BeW+t44POwNwqtVJM6utEnbEkya2
         85fMez+ffcLIXYx24m0qzpmEpfYHKmde8q89kgum68n1mtgpwVTzvAdTbRnB7loLomI/
         4AC3TDFgB8nB6h2KVhvp3WpPfCaqYmdaiG0sOmAKW4vZ8RnIWpsRRbWcUAarQag62QAc
         FDxE4Vz7Bnmt1IKElVVqzlumS4OSyUhkXbuLIWINYtETC3jIBumQOwkiS/NliCObvWA1
         iFug==
X-Gm-Message-State: APjAAAV8yLLzZRviee2ledrdxPKHWihR+QVCC9XWS3cDqeqBuJCzX+nF
        sJqZiX0w/yCVNb3sJayVIjwsoJ/zasUInUmNy3vtt1fy12zj6vVneIFEP8+XEI4Ut2NzqVL3qth
        VXvmA4QdqmtuuTlz1/LL4fBnd
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr158659wml.138.1578608231535;
        Thu, 09 Jan 2020 14:17:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGgG+zdReeEQS/nMSxy1x2Y3qZeVhuNTD0Ox+Ud68xCaogVcxJC/WD6f/iGqdfCRn5/jFA8g==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr158633wml.138.1578608231341;
        Thu, 09 Jan 2020 14:17:11 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6BE2.dip0.t-ipconnect.de. [91.12.107.226])
        by smtp.gmail.com with ESMTPSA id d8sm9586735wre.13.2020.01.09.14.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 14:17:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
Date:   Thu, 9 Jan 2020 23:17:09 +0100
Message-Id: <A7C7E3ED-3A02-43C7-B739-53A7756822D4@redhat.com>
References: <20200109140004.d5e6dc581b62d6e078dcca4c@linux-foundation.org>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>, nathanl@linux.ibm.com,
        ricklind@linux.vnet.ibm.com, mhocko@suse.com,
        Scott Cheloha <cheloha@linux.ibm.com>
In-Reply-To: <20200109140004.d5e6dc581b62d6e078dcca4c@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.01.2020 um 23:00 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@linux.v=
net.ibm.com> wrote:
>=20
>> Searching for a particular memory block by id is an O(n) operation
>> because each memory block's underlying device is kept in an unsorted
>> linked list on the subsystem bus.
>>=20
>> We can cut the lookup cost to O(log n) if we cache the memory blocks in
>> a radix tree.  With a radix tree cache in place both memory subsystem
>> initialization and memory hotplug run palpably faster on systems with a
>> large number of memory blocks.
>>=20
>> ...
>>=20
>> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys =3D {
>>    .offline =3D memory_subsys_offline,
>> };
>>=20
>> +/*
>> + * Memory blocks are cached in a local radix tree to avoid
>> + * a costly linear search for the corresponding device on
>> + * the subsystem bus.
>> + */
>> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
>=20
> What protects this tree from racy accesses?

I think the device hotplug lock currently (except during boot where no races=
 can happen).=

