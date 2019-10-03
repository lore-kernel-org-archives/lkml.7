Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF0C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660CB222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linode-com.20150623.gappssmtp.com header.i=@linode-com.20150623.gappssmtp.com header.b="pY8KhI5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbfJCUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:32:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35789 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfJCUct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:32:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so5541890qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linode-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:autocrypt:organization:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=he1x5GSXn01a2ngbcDimTKtyG35ArN8YpbDsFxNkvUY=;
        b=pY8KhI5M2C5GMHvtKjQvwnxvvpdOfRMKmMWSndN3i0VJdxKWakjKQQ1GRujBNVrC9b
         41GjqXrWjGqsXc+YAEfBwUxD0rQ7Bi5Qx28aFyS9EI4iIYjgEHwHIphzXzRXT5W/zmmo
         C4akZV2YWQSZK9sgg7rC8sU/Z8pHIyhLFyjVbsvDiJHyBmQiuoZtzmVn8uMTbqNw8c75
         i35nduVHOlMl5PNqvUsKmXMilEuHQpgjQ6LbxdX5oMnljjs4NO0DwWT2oy67/lmZXc3L
         sUn0keujAFqDLl3QrhP5IGdg4YS5V0nTbdAxSfOq99uYhOWNZAhIowNl84t0DjU7FQvg
         a02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:autocrypt:organization:to
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=he1x5GSXn01a2ngbcDimTKtyG35ArN8YpbDsFxNkvUY=;
        b=oOGolGmn6hBj7+gGwm3H8cWBQtyrjn3bDyrVT+CY6AVyoV91FZnDIRtBTsXcIJk8W9
         XcAJBXiKpqcqCO7/GssZCNG9/jblaVLrSXT8kf+ndi5NJe/cp/w+QhF4otUsQAxiDc3x
         930fcaEiqdcJoZValvMRmyD4vRwIktqN1IEPbVJ52kjmx270etptXJ9EoM4g6zyDPwAf
         Ora4Kg6vRAUfYiyzZ0H1pOK09h9JJ2z0ltPYShcZQAirOWY5RTUR0xDUYuZVVG3Benp4
         Y4ovyrIOyBzh3CAecwhzu24d8BNIfT0RjYKhz+se52letB5tcYxqZ1PNnEw94cmbO9I6
         yFhg==
X-Gm-Message-State: APjAAAXnULUPvHx/r9mOsrJu8AarIu+h13m/HajPVSO6OTnmAvxJC08c
        3O8+HvFT9qH98IYa4/GtE4VRNE0vS+jxKP33wF+JodBm/SEqSuQuQTKvthZQ/9cUMh8S4iupty3
        bRgp9HekPKaczoAkrevAFVM/xIJQHILIbBZENl5wKDga7bz9tnUHaqUKdqjVhZU3d6B6dQWjuCn
        W1
X-Google-Smtp-Source: APXvYqxo5KarS9oFjqYuvejLtr3Cscc/gJUbubfIteXf2XMtnNXEgk/Xad3xQh78dEgfu+XoS4Ly8g==
X-Received: by 2002:ac8:5357:: with SMTP id d23mr12365461qto.223.1570134767694;
        Thu, 03 Oct 2019 13:32:47 -0700 (PDT)
Received: from [172.16.22.130] ([172.104.2.4])
        by smtp.gmail.com with ESMTPSA id w2sm2233155qtc.59.2019.10.03.13.32.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 13:32:47 -0700 (PDT)
From:   Bradley LaBoon <blaboon@linode.com>
Subject: SCSI device probing non-deterministic in 5.3
Autocrypt: addr=blaboon@linode.com; prefer-encrypt=mutual; keydata=
 mQENBFnSOxYBCAC4hL/8AuiiKp/WamEAd5nf7JGVPHR5fZ2EmEgGtYOnypwaDY0uwFmTV4gR
 nJ8CCsBX7AtVKVLob+zwxaTFniRnamvcuirE5+sVGIChb2GVLAxjqRRXkrKYgisCjIwCXQFu
 FYKzpRksRaPZloLghlp36bAAPm7KIiACbb1W33PrxHHJPz99N5v3bJvc4/8cH1MoEOdnLHH1
 3zGzcyBeL3JIsRGS0jC3VT5qs9zO1DsL/X6vBYwYkjSve5vFCsTMmVKZFL8aeGDRt09/8EoM
 YlmgI/fctO8jHiF2VCMWH3Dq5i7NH+jYQ4/SqeXCxqhWlxXf+FXFS3eW741h9P7LB9RJABEB
 AAG0I0JyYWRsZXkgTGFCb29uIDxibGFib29uQGxpbm9kZS5jb20+iQFUBBMBCAA+AhsDBQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAFiEEbS4MuuHK2wr7CfjY2AcDUfXj3UAFAl1wERsFCQV/
 CYUACgkQ2AcDUfXj3UAlqAf/UrwkrW4kITCiOaIykfVogTbJ54RBwy9Qmi9HbWMG/o+wNwhO
 GDjD0l5362mXQVP2V/TQwrx/e1kGTTC5PFv/xN6vT1oXIwxzn1lezr5eBA53KgV2paBBZ4Qo
 ALpoI4UJn6YYIhD14BUw3Fn2o15a/pvSz9vxx70NjEbT1Or0gxaRZuam62fMbsLM327ikhau
 lWQSdVZs3rdMzFCz87F0CiwNtfKU730/JLeJGuIfXFDb8W/XLWc7JHaL8gIn+kS/0/Txgl8Q
 pfXQ6E2vnQojlXDmo4WYhbDxwzw4R9Kv8E6S25CuoP+8tmbHdB8NRXdhZ4nMU1TON5tKd1BG
 Sh+MobkBDQRZ0jsWAQgA5fxyts5E5WmgifFoVMfGmhPyGFE5KdYM2cREWypaTgRIWqxznDdM
 7ODabZzlWVrgW2o3DyzdRW6vXAW96lDB9Riug4kPTYOz8gkPuJG2SA1pGgkykLIVlpN28pFQ
 O4s0C0Xe4LxfzjniWtbshm0+fQCMfaA7/7A0iZiP2N6ikr8cYJw/nsQsMCrml5oStEl1T8/2
 oBzHz6VxsUuNlXxgurgDYJBRmlUMw3BV9aKgg7SgHhW19SmG3TfzydH5KXReLynCDMFnyXeW
 yNuBnuqgYI8VKiOSz5v+OfqhPGHvUdqUgTagVgLaEORdZB6Z84qM3jnHvZVtxT9KVca98vCn
 7wARAQABiQE8BBgBCAAmAhsMFiEEbS4MuuHK2wr7CfjY2AcDUfXj3UAFAl1wETMFCQV/CZ0A
 CgkQ2AcDUfXj3UBcQQf/YEjNvpWmsp3tMkECTl+Xaxsm5dyxn9+dM6VQ0vPeI5t/7tpevIJs
 a0jLeiTz5qa2uDZVd+LhlXj8oMoOYYQWa/3OwXaKgigtFTXSSrXimKVqvgf5LVpw3g83x/99
 mas/Kv+aJ9+6QA6dTYLEbMuzlt1TPF5go1watceQapxN09pkouoG5Yt/GhbX1OSg9WXiaOZ0
 USJ3f3jifWWJ7NkRV2yzio6IMqbStJtuk097PiVv7r2BUuurrYkWTQbVemBx2qDTpQHWuIn7
 nxR9YeutMRR02dm9249dQcA6GyF256HMQty/CDBiIX5xeth1OCgX8VL6SWcCSd0t/k3+zHw9 Ag==
Organization: Linode, LLC
To:     linux-kernel@vger.kernel.org
Message-ID: <d2ff27ce-67b0-735e-8652-0e925d5f756c@linode.com>
Date:   Thu, 3 Oct 2019 16:32:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, LKML!

Beginning with kernel 5.3 the order in which SCSI devices are probed and
named has become non-deterministic. This is a result of a patch that was
submitted to add asynchronous device probing (specifically, commit
f049cf1a7b6737c75884247c3f6383ef104d255a). Previously, devices would
always be probed in the order in which they exist on the bus, resulting
in the first device being named 'sda', the second device 'sdb', and so on.

This is important in the case of mass VM deployments where many VMs are
created from a single base image. Partition UUIDs cannot be used in the
fstab of such an image because the UUIDs will be different for each VM
and are not known in advance. Normally you can't rely on device names
being consistent between boots, but with QEMU you can set the bus order
of each block device and thus we currently use that to control the
device order in the guest. With the introduction of the aforementioned
patch this is no longer possible and the device ordering is different on
every boot, resulting in the guest booting into an emergency shell
unless the devices randomly happen to be loaded in the expected order.

I have created a patch which reverts back to the previous behavior, but
I wanted to open this topic to discussion before posting it. I'm not
totally familiar with the low-level details of SCSI device probing, so I
don't know if the non-deterministic device order was the intended
behavior of the patch or just a side-effect. If that is the intended
behavior then is there perhaps some other way to ensure a consistent
device ordering for a guest VM?

I am not subscribed to the list, so please CC me on any replies.

Thank you!
Bradley LaBoon
