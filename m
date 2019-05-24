Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67F2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbfEXF2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:28:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:33168 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfEXF2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:28:05 -0400
Received: by mail-it1-f199.google.com with SMTP id 15so5287551ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=q9cCO7nqhlgXyUNz1cM4/Qf9S/SQ2WkjNSQAnXjcv4s=;
        b=BvlU8Br1CscFYDcJ2hSz94dkjJpeheega2760oLSHXP+sqQDl2qeAHPmqwfZRGzwMd
         CEOzzzfffgvxZ+j5QPXs0E1RfHD1DL1qnTmgfRNg0aS5xwHmsv+ruhG0Lg7e5nfNkAlq
         u3tZZQtnvxY3/dSq4eT8lhlOZwPqJcs9pJ7taJnBY+YZV8jVNk4rUbQ/eLuQcEIYvw1Y
         1cy6lExtWOsbJWTBNDiT8SVVm5Q1N3mfRmzVUcXktvPs5rYDbKFzZZB4UtFK1YoFqNee
         qvuvET7q5vel9TthQdVZn+3nfE3AjEtpo0eUfw2bSwYAXEgBQHqkr1vndK613iPNpQKy
         4B6g==
X-Gm-Message-State: APjAAAX3GiyNzK4FfqQ/D37UKY4gpAEfIZk+bjUgYStl20JV7pcSM5Jk
        pjbxtuv7KN2+dErOuVJO4nNzP2mKdOqKt9VARn74Z9n7J9sl
X-Google-Smtp-Source: APXvYqwDDOZn9e8caYZRqq7PZLeP8M7Or+hKD8jRpeN8/ApSvkZcSA2QFvEj87ml6/PDfg0cFh0P0TXKwMQFezxY0xt/kXgpZiGt
MIME-Version: 1.0
X-Received: by 2002:a24:ac0a:: with SMTP id s10mr18291167ite.60.1558675685007;
 Thu, 23 May 2019 22:28:05 -0700 (PDT)
Date:   Thu, 23 May 2019 22:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008666df05899b7663@google.com>
Subject: bpf build error
From:   syzbot <syzbot+cbe357153903f8d9409a@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnN5emJvdCBmb3VuZCB0aGUgZm9sbG93aW5nIGNyYXNoIG9uOg0KDQpIRUFEIGNv
bW1pdDogICAgZTZmNmNkMGQgYnBmOiBzb2NrbWFwLCBmaXggdXNlIGFmdGVyIGZyZWUgZnJvbSBz
bGVlcCBpbiBwcy4uDQpnaXQgdHJlZTogICAgICAgYnBmDQpjb25zb2xlIG91dHB1dDogaHR0cHM6
Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTZmMTE2ZTRhMDAwMDANCmtlcm5l
bCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD1mYzA0
NTEzMTQ3Mjk0N2Q3DQpkYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPWNiZTM1NzE1MzkwM2Y4ZDk0MDlhDQpjb21waWxlcjogICAgICAgZ2NjIChH
Q0MpIDkuMC4wIDIwMTgxMjMxIChleHBlcmltZW50YWwpDQoNClVuZm9ydHVuYXRlbHksIEkgZG9u
J3QgaGF2ZSBhbnkgcmVwcm9kdWNlciBmb3IgdGhpcyBjcmFzaCB5ZXQuDQoNCklNUE9SVEFOVDog
aWYgeW91IGZpeCB0aGUgYnVnLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnIHRvIHRoZSBj
b21taXQ6DQpSZXBvcnRlZC1ieTogc3l6Ym90K2NiZTM1NzE1MzkwM2Y4ZDk0MDlhQHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20NCg0KbmV0L2NvcmUvc2tidWZmLmM6MjM0MDo2OiBlcnJvcjog4oCY
c3RydWN0IG1zZ2hkcuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmGZsYWdz4oCZDQoNCi0tLQ0K
VGhpcyBidWcgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90LiBJdCBtYXkgY29udGFpbiBlcnJvcnMuDQpT
ZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZvciBtb3JlIGluZm9ybWF0aW9uIGFib3V0IHN5emJv
dC4NCnN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQgYXQgc3l6a2FsbGVyQGdvb2dsZWdy
b3Vwcy5jb20uDQoNCnN5emJvdCB3aWxsIGtlZXAgdHJhY2sgb2YgdGhpcyBidWcgcmVwb3J0LiBT
ZWU6DQpodHRwczovL2dvby5nbC90cHNtRUojc3RhdHVzIGZvciBob3cgdG8gY29tbXVuaWNhdGUg
d2l0aCBzeXpib3QuDQo=
