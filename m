Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B478C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D02464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="rsUdEEXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgADPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:51:54 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:39388 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgADPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:51:54 -0500
Received: by mail-qv1-f42.google.com with SMTP id y8so17419175qvk.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=kFvmKQqYa2fX4vcTqRj6WrzUk1mEFZ1omXDTHB1IJsI=;
        b=rsUdEEXP/ry2Su+XInNONl9UxGHK66rXVF5FPuR7h882aYVfn2VS75R789t9/fLSip
         Lc+NFlXigMBfVeiZBBsRMtfYn3Ki4ClUiwEbr8Yby2nOPPg8OiqZrusQzTgZWk45IfeV
         8b+X7K180vKT0KgCIyPrPsbLcmfRJYJEKQ5G1/eyC+TALJu7zN6HMbHqDOlYvSqL6KgC
         VcYjIjk83kxMpSKTflk7twU24KtcnpliPGGYmhrjOUmUPpM8jEV5+bNexSSuuLgAfxQ+
         GEGXKVubclfBmVUNUjcELvyxQ07kTLu4tBRPITPcgOvDl2W8hiT+D0fSo5aUiIhi5Jvy
         G/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=kFvmKQqYa2fX4vcTqRj6WrzUk1mEFZ1omXDTHB1IJsI=;
        b=HRpbUtxhWNzbsrZh/J/P23JFjiJrMP9WA0E6/YoDFfmxb2hXnC0oFjunQ/EP05mRDC
         BYKLVB9288DQ9ZpDEQK7+z46oBe8Psm45br2kGaGoA4+agEUbi1Rt/+fzbG9YLNkdowx
         oOBHKGYRw+EpdDBjs/VWcKZtuhtevBKSP8AM5tBKCUPxhrKrPAcj/SQfQ5DB1LK+eQI6
         hjmeqx7fI+ltfuABEhsDJKltbTu7cgafC7v5Z60GGYoh0ud3O/Fb2AJWZcpjrwECepG7
         P8wJt1vkehE+V0MzdkmSv5U8NfoqGY0nFt5s+2Y6ZZAtHW74uyTacd6crbBd+cezML3t
         LEMw==
X-Gm-Message-State: APjAAAVNAB2UOEWZJe5Tp4ZoUUid+oTrhL/mQjB9lwy1svDElV4bWiuO
        SOW5Th0zYbzu/vfHLdM5SSgyVwBOdPo=
X-Google-Smtp-Source: APXvYqzO27OX9tk5oQHKlh8Vr62mw5ThQ9BtArNbHOdk1e8KyFmReR/YQ7AkDUwP15SFuloEwkyqSQ==
X-Received: by 2002:a05:6214:94b:: with SMTP id dn11mr9983603qvb.12.1578153113379;
        Sat, 04 Jan 2020 07:51:53 -0800 (PST)
Received: from [192.168.1.120] (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id f26sm20216042qtv.77.2020.01.04.07.51.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 07:51:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jon Masters <jcm@jonmasters.org>
Mime-Version: 1.0 (1.0)
Date:   Sat, 4 Jan 2020 10:51:52 -0500
Subject: nf_nat not running in a netns
Message-Id: <29555895-6D59-4415-B44C-5AD90C14C63F@jonmasters.org>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Can anyone offer any reasons why the nat table chains for a netns wouldn=E2=80=
=99t be running?

Longer detail:

I=E2=80=99ve be playing with Kolla (containerized OpenStack) and the way the=
y implement (virtual) routers for tenant networks is to create network names=
paces with interfaces representing the ports plugged into the router. To tra=
nslate addresses from internal to external networks, they apply D/SNAT rules=
 within that netns. All of these are created and the interfaces are pingable=
, but the nat rules aren=E2=80=99t being run and the untranslated addresses a=
re ultimately seen on the physical network once packets traverse out of the c=
ontainers and to the external neutron interface.

Jon.

--=20
Computer Architect

