Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AEF20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfCYAM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:12:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44584 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfCYAM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:12:27 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 33CF1108AE13A;
        Sun, 24 Mar 2019 17:12:27 -0700 (PDT)
Date:   Sun, 24 Mar 2019 20:12:26 -0400 (EDT)
Message-Id: <20190324.201226.2195904854628723725.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     gerrit@erg.abdn.ac.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org
Subject: Re: [PATCH v2] dccp: Fix memleak in __feat_register_sp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190322134348.15048-1-yuehaibing@huawei.com>
References: <20190322134348.15048-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Mar 2019 17:12:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVlIEhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCkRhdGU6IEZyaSwgMjIg
TWFyIDIwMTkgMjE6NDM6NDggKzA4MDANCg0KPiBGcm9tOiBZdWVIYWliaW5nIDx5dWVoYWliaW5n
QGh1YXdlaS5jb20+DQo+IA0KPiBJZiBkY2NwX2ZlYXRfcHVzaF9jaGFuZ2UgZmFpbHMsIHdlIGZv
cmdldCBmcmVlIHRoZSBtZW0NCj4gd2hpY2ggaXMgYWxsb2NlZCBieSBrbWVtZHVwIGluIGRjY3Bf
ZmVhdF9jbG9uZV9zcF92YWwuDQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2Np
QGh1YXdlaS5jb20+DQo+IEZpeGVzOiBlOGVmOTY3YTU0ZjQgKCJkY2NwOiBSZWdpc3RyYXRpb24g
cm91dGluZXMgZm9yIGNoYW5naW5nIGZlYXR1cmUgdmFsdWVzIikNCj4gU2lnbmVkLW9mZi1ieTog
WXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gdjI6IGtmcmVlICd2
YWwgLS0+ICdmdmFsJw0KDQpEb24ndCBzdWJtaXQgYW55IHBhdGNoZXMgZm9yIGF0IGxlYXN0IDIg
ZGF5cywgSSBhbSBnZXR0aW5nIHJlYWxseSB0aXJlZCBvZg0KY2hhbmdlcyB5b3UgZG9uJ3QgZXZl
biBDT01QSUxFIFRFU1Q6DQoNCiAgQ0MgW01dICBuZXQvZGNjcC9mZWF0Lm8NCm5ldC9kY2NwL2Zl
YXQuYzogSW4gZnVuY3Rpb24goV9fZmVhdF9yZWdpc3Rlcl9zcKI6DQpuZXQvZGNjcC9mZWF0LmM6
NzQyOjEzOiBlcnJvcjogaW52YWxpZCB0eXBlIGFyZ3VtZW50IG9mIKEtPqIgKGhhdmUgoWRjY3Bf
ZmVhdF92YWyiIHtha2EgoXVuaW9uIDxhbm9ueW1vdXM+on0pDQogICBrZnJlZShmdmFsLT5zcC52
ZWMpOw0KICAgICAgICAgICAgIF5+DQo=
