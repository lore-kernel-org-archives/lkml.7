Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB63FFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2C207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGkoD3I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405311AbfJPW7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:59:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726965AbfJPW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571266745;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyiMlWJkqAf8MO4pTs8/WbLKzyR9A5LqxtBH32MGUbQ=;
        b=EGkoD3I3DTgw/WShNfXNPwkX7Qycm7b3GbyA3bMJpVzq+dBSFEeqTh8sA5ynB7Nx8Q/9D2
        OXPhAilrWUFEUAoABf1A6kiP75moOmsy1hsdJHLdK7AK1QQx42KFKnu3pivBk/Qxnx8iT9
        sx9zE30082C6lTw7GK++iKtpabEpaTY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-VmxnFOSWN7q3WB6g9jRpIQ-1; Wed, 16 Oct 2019 18:59:03 -0400
Received: by mail-io1-f70.google.com with SMTP id g15so479496ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 15:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=izr2IsFI8KdP3bcHd0eKxqMK3CSawZuxmuGffwvF3wM=;
        b=NB5GyzB0ankfvvCy3ujxVXHYkzdunyaIptwOhjN9tyl+j32beccyXMOhp4S2NA+gjh
         X6lh7JpAu11uC6ZR0DfxrJi75iGQCA+NcpDKzq3odhaSXCZVAM+ERkGoq82w7v/W6fQD
         ozJYbw4i65q0XuU66Aj3YqssE9xp6jG7LBtcHXfY+Rle9IknqUxKyQlwOqL8CYd4K7j6
         dmVuOxouik1DZkd7audo/2EbXYpr0gL5aPDQ1EBJp0luzN7YEp1hgcfJhv9/qtLDDlVy
         S1d+5b+Uund3b2R0ndAmzxSu1J4pN2UQHj2kFQGSurmSkotDN7r/f/+/FSNsfTFkF/am
         sI5Q==
X-Gm-Message-State: APjAAAWZY1ARTizq7Z1uKlXDCzKWFH4ox6IM4JkCLC/PTISg1GWxXu7+
        LUln+qarp6HGFIQDS8ehqv4OrCPvSgZi7Kvr2jJiEVSwIfbdWX7Ve+7S1st0pomPiWsdr83dGnV
        JLOwWxGCdXlAekjjMzICgkcDF
X-Received: by 2002:a02:7124:: with SMTP id n36mr450931jac.90.1571266743021;
        Wed, 16 Oct 2019 15:59:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXgcSDWOvFVRU4qEgI4WtmHcPsJHr4aMIDVzx1G2HnyuwCQ56ZEGP2XRwkkjSFyOMu6fRo6A==
X-Received: by 2002:a02:7124:: with SMTP id n36mr450914jac.90.1571266742774;
        Wed, 16 Oct 2019 15:59:02 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id t8sm101183ild.7.2019.10.16.15.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 15:59:01 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:58:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de, don.brace@microsemi.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH -next] iommu/amd: fix a warning in increase_address_space
Message-ID: <20191016225859.j3jq6pt73mn56chn@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Qian Cai <cai@lca.pw>, jroedel@suse.de,
        don.brace@microsemi.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        esc.storagedev@microsemi.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <1571254542-13998-1-git-send-email-cai@lca.pw>
 <20191016220415.cbam7qk3pxjmw4gi@cantor>
MIME-Version: 1.0
In-Reply-To: <20191016220415.cbam7qk3pxjmw4gi@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: VmxnFOSWN7q3WB6g9jRpIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 16 19, Jerry Snitselaar wrote:
>On Wed Oct 16 19, Qian Cai wrote:
>>
>>BTW, Joerg, this line from the commit "iommu/amd: Remove domain->updated"=
 looks
>>suspicious. Not sure what the purpose of it.
>>
>>*updated =3D increase_address_space(domain, gfp) || *updated;
>>
>
>Looking at it again I think that isn't an issue really, it would just
>not lose updated being set in a previous loop iteration, but now
>I'm wondering about the loop itself. In the cases where it would return
>false, how does the evaluation of the condition for the while loop
>change?
>

I guess the mode level 6 check is really for other potential callers
increase_address_space, none exist at the moment, and the condition
of the while loop in alloc_pte should fail if the mode level is 6.

