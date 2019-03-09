Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090E9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC822081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bCGEkxWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfCILvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 06:51:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfCILvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 06:51:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so93852pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 03:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SHdcpUe+7NMAZTDuihMnvacgeL9Jtpkx4IQYNPmRFz8=;
        b=bCGEkxWq59cSjC+sCsBOGTDwWwKOlEhNMxgwlQDhuJGk4V7qasAWgH2KMV5y21fneI
         goZLzaazQAKdSRbTtN0gey5JB7reYTH+NGKBXjxcqHZ5ba9aK8kxMJGelRmHkfnuLdSj
         oTiacsW4/CZ3cH+jfm3FnTXypamo6p56fzsFfgq5wHcczZx1PMM3epaAfEO2fet5+U0k
         18V6brUwmX41hpkuvvuMJvv8JrFehXU1Jorki6mlJcXUXtbSwKE7xY5/uCGlJQ5eREAY
         oscrRAqVuNqnfhoESrLA2Vgh/2eE7+BKWK+B6Knt0SHo+AGJw0Z56bsPAEA/gkhj0SA6
         dowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SHdcpUe+7NMAZTDuihMnvacgeL9Jtpkx4IQYNPmRFz8=;
        b=mSUMR2xNDz/ZApAim9OFXMC11bBTI/4y4ZROLwZL+k2ntjSm/9Omu64UPKVdyuu/61
         yo/s+FiqPMVXN6zMdwQR6oBdndDIGBzffdZN762YuVo0QVvh4LaykBYU+0i93P2GCvA3
         yWsD9PJ6VXOA82F+iaaRREju85FiGeprXSJj+0QCGeXX7EyBwI7GeKit1Q6TShGl7ZHQ
         QMtsc2MKDiyZIPKq5lb8s39G7VBwM5FccQEq3fQW9A5Jzv/x3Y0jMuvMsd+SMwTT6QvB
         IW9PeBUbO54znGHhg34vBUStCX07G0CYM6iRgAg6Xvzun0gRrmJHcXu/tj5roYmdcjjl
         IubQ==
X-Gm-Message-State: APjAAAXx+R0o04Bnx5yuFGgNvpCXy2hBp/9LqFycKYoRgUAvwwiL8aMH
        az315p+0p8A0PhoTeMYg2UWrgA==
X-Google-Smtp-Source: APXvYqzDPWkOongbiRKMav4i2cwKi5sHERu/qEChnudZZGFPojgl9ft7bMWxI9yyq83HeRlZooy92g==
X-Received: by 2002:a62:e0ca:: with SMTP id d71mr23105817pfm.62.1552132259453;
        Sat, 09 Mar 2019 03:50:59 -0800 (PST)
Received: from [192.168.0.150] ([37.228.251.244])
        by smtp.gmail.com with ESMTPSA id l7sm3346582pfj.162.2019.03.09.03.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 03:50:58 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
Date:   Sat, 9 Mar 2019 11:49:46 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7A831AB-A7A0-407F-A7E3-B84E354E9986@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
 <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
 <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
 <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Lu,

> On 9 Mar 2019, at 01:53, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/9/19 12:57 AM, James Sewart wrote:
>> Hey Lu,
>>> On 8 Mar 2019, at 03:09, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>>>=20
>>>>> Do you mind if I work on top of your patches for further cleanups =
and
>>>>> sign off a v2 together with you?
>>>> Sure, sounds good. I=E2=80=99ll fixup patch 3 and have a go at =
integrating
>>>> iommu_prepare_isa into get_resv_regions. This should make the =
initial
>>>> domain logic here quite concise.
>>> Here attached three extra patches which I think should be added =
before
>>> PATCH 3/4, and some further cleanup changes which you can merge with
>>> PATCH 4/4.
>>>=20
>>> ----------------
>>>=20
>>> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
>>> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>>>=20
>>> These two patches aim to add a generic method for vendor specific =
iommu
>>> drivers to specify the type of the default domain for a device. =
Intel
>>> iommu driver will register an ops for this since it already has its =
own
>>> identity map adjudicator for a long time.
>> This seems like a good idea, but as domain alloc is only called for =
the
>> default domain on first device attached to a group, we may miss =
checking
>> whether a device added later should have an identity domain. Should =
there
>> be paths to downgrade a groups domain if one of the devices requires =
one?
>=20
> Good catch!
>=20
> This is supposed to be handled in iommu_no_mapping(). But, obviously
> current code sticks to lazy domain allocation. I'm not sure whether
> there are any real such cases, but we should handle it in a clean way.
> My idea is that we could downgrade to multiple domains per group (just
> like what we have now) in this case and print a kernel message for =
this.

I think if a device requires an identity domain, then it should ignore=20=

attempts to attach to something else. A print to warn a user about this=20=

would be a good idea.

I figure during attach: if iommu_no_mapping() then attach to si_domain =
and=20
print, else continue with the given domain.

>=20
> Or any other thoughts?
>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
