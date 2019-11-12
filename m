Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55423C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287672084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKLOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:16:16 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:46123 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbfKLOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:16:15 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xACEFOFK069216
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 12 Nov 2019 22:15:25 +0800 (CST)
        (envelope-from lvqiang.huang@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 12 Nov 2019
 22:15:07 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.0847.030; Tue, 12 Nov 2019 22:14:55 +0800
From:   =?gb2312?B?u8bCwMe/IChMdnFpYW5nIEh1YW5nKQ==?= 
        <lvqiang.huang@unisoc.com>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "yj.chiang@mediatek.com" <yj.chiang@mediatek.com>,
        "alix.wu@mediatek.com" <alix.wu@mediatek.com>,
        "mike-sl.lin@mediatek.com" <mike-sl.lin@mediatek.com>,
        "eddy.lin@mediatek.com" <eddy.lin@mediatek.com>,
        "phil.chang@mediatek.com" <phil.chang@mediatek.com>,
        =?gb2312?B?s/6298C0IChFbmxhaSBDaHUp?= <enlai.chu@unisoc.com>
Subject: Re: [PATCH] ARM: fix race in for_each_frame
Thread-Topic: [PATCH] ARM: fix race in for_each_frame
Thread-Index: AQHVmV2AMhVdltuogk6mbCoumJ6bbKeHlGHg
Date:   Tue, 12 Nov 2019 14:14:54 +0000
Message-ID: <C1108AB0-9156-426F-A933-486B4F5C91CF@unisoc.com>
References: <20191112132937.19335-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20191112132937.19335-1-mark-pk.tsai@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com xACEFOFK069216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


DQo+INTaIDIwMTnE6jEx1MIxMsjVo6wyMTozMaOsTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlA
bWVkaWF0ZWsuY29tPiDQtLXAo7oNCj4gDQo+IFRoZSBzdl9wYywgd2hpY2ggaXMgc2F2ZWQgaW4g
dGhlIHN0YWNrLCBtYXkgYmUgYW4gaW52YWxpZCBhZGRyZXNzDQo+IGlmIHRoZSB0YXJnZXQgdGhy
ZWFkIGlzIHJ1bm5pbmcgb24gYW5vdGhlciBwcm9jZXNzb3IgaW4gdGhlIG1lYW50aW1lLg0KPiBJ
dCB3aWxsIGNhdXNlIGtlcm5lbCBjcmFzaCBhdCBgbGRyIHIyLCBbc3ZfcGMsICMtNF1gLg0KPiAN
Cj4gQ2hlY2sgaWYgc3ZfcGMgaXMgdmFsaWQgYmVmb3JlIHVzZSBpdCBsaWtlIHVud2luZF9mcmFt
ZSBpbg0KPiBhcmNoL2FybS9rZXJuZWwvdW53aW5kLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWtlLVNMIExpbiA8bWlrZS1zbC5saW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJrLVBLIFRzYWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiBhcmNoL2Fy
bS9saWIvYmFja3RyYWNlLlMgfCA1ICsrKysrDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9saWIvYmFja3RyYWNlLlMgYi9hcmNo
L2FybS9saWIvYmFja3RyYWNlLlMNCj4gaW5kZXggNTgyOTI1MjM4ZDY1Li44NGYwNjM4MWJiZmIg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2xpYi9iYWNrdHJhY2UuUw0KPiArKysgYi9hcmNoL2Fy
bS9saWIvYmFja3RyYWNlLlMNCj4gQEAgLTY0LDYgKzY0LDExIEBAIGZvcl9lYWNoX2ZyYW1lOiAg
ICB0c3QgICAgZnJhbWUsIG1hc2sgICAgICAgIEAgQ2hlY2sgZm9yIGFkZHJlc3MgZXhjZXB0aW9u
cw0KPiAgICAgICAgc3ViICAgIHN2X3BjLCBzdl9wYywgb2Zmc2V0ICAgIEAgQ29ycmVjdCBQQyBm
b3IgcHJlZmV0Y2hpbmcNCj4gICAgICAgIGJpYyAgICBzdl9wYywgc3ZfcGMsIG1hc2sgICAgQCBt
YXNrIFBDL0xSIGZvciB0aGUgbW9kZQ0KPiANCj4gKyAgICAgICAgbW92ICAgIHIwLCBzdl9wYw0K
PiArICAgICAgICBibCAgICBrZXJuZWxfdGV4dF9hZGRyZXNzICAgIEAgY2hlY2sgaWYgc3ZfcGMg
aXMgdmFsaWQNCj4gKyAgICAgICAgY21wICAgIHIwLCAjMCAgICAgICAgICAgIEAgaWYgc3ZfcGMg
aXMgbm90IGtlcm5lbCB0ZXh0DQo+ICsgICAgICAgIGJlcSAgICAxMDA2ZiAgICAgICAgICAgIEAg
YWRkcmVzcywgYWJvcnQgYmFja3RyYWNlDQo+ICsNCg0KVGhlIHN2X3BjIGNhbiBiZSBhIGtlcm5l
bCBtb2R1bGUgdGV4dC4gDQoNCj4gMTAwMzogICAgICAgIGxkciAgICByMiwgW3N2X3BjLCAjLTRd
ICAgIEAgaWYgc3RtZmQgc3AhLCB7YXJnc30gZXhpc3RzLA0KPiAgICAgICAgbGRyICAgIHIzLCAu
TGRzaSs0ICAgICAgICBAIGFkanVzdCBzYXZlZCAncGMnIGJhY2sgb25lDQo+ICAgICAgICB0ZXEg
ICAgcjMsIHIyLCBsc3IgIzExICAgICAgICBAIGluc3RydWN0aW9uDQo+IC0tIA0KPiAyLjE4LjAN
Cg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIGVtYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFj
aG1lbnRzKSBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aGlj
aCBpdCBpcyBhZGRyZXNzZWQgYW5kIG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJp
dmlsZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVyd2lzZSBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9z
dXJlLiBVbmF1dGhvcml6ZWQgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29w
eWluZyBvZiB0aGlzIGVtYWlsIG9yIHRoZSBpbmZvcm1hdGlvbiBoZXJlaW4gb3IgdGFraW5nIGFu
eSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgb3IgdGhl
IGluZm9ybWF0aW9uIGhlcmVpbiwgYnkgYW55b25lIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJl
Y2lwaWVudCwgb3IgYW4gZW1wbG95ZWUgb3IgYWdlbnQgcmVzcG9uc2libGUgZm9yIGRlbGl2ZXJp
bmcgdGhlIG1lc3NhZ2UgdG8gdGhlIGludGVuZGVkIHJlY2lwaWVudCwgaXMgc3RyaWN0bHkgcHJv
aGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRv
IG5vdCByZWFkLCBjb3B5LCB1c2Ugb3IgZGlzY2xvc2UgYW55IHBhcnQgb2YgdGhpcyBlLW1haWwg
dG8gb3RoZXJzLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIHBlcm1h
bmVudGx5IGRlbGV0ZSB0aGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGlmIHlvdSByZWNl
aXZlZCBpdCBpbiBlcnJvci4gSW50ZXJuZXQgY29tbXVuaWNhdGlvbnMgY2Fubm90IGJlIGd1YXJh
bnRlZWQgdG8gYmUgdGltZWx5LCBzZWN1cmUsIGVycm9yLWZyZWUgb3IgdmlydXMtZnJlZS4gVGhl
IHNlbmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmlsaXR5IGZvciBhbnkgZXJyb3JzIG9yIG9taXNz
aW9ucy4gDQqxvtPKvP68sMbkuL28/r7f09Cxo8Pc0NTWyqOsyty3qMLJsaO7pLK7tcPQucK2o6y9
9reiy824+LG+08q8/sv51rjM2LaoytW8/sjLoaPRz737t8e+rcrayKjKudPDoaLQ+7SroaK3orK8
u/K4tNbGsb7Tyrz+u/LG5MTayN2ho8j0t8e4w8zYtqjK1bz+yMujrMfrzvDUxLbBoaK4tNbGoaIg
yrnTw7vyxfvCtrG+08q8/rXEyM66zsTayN2ho8j0zvPK1bG+08q8/qOsx+u008+1zbPW0NPAvsPQ
1Mm+s/2xvtPKvP68sMv509C4vbz+o6yyotLUu9i4tNPKvP61xLe9yr28tL/MuObWqreivP7Iy6Gj
zt63qLGj1qS7pcGqzfjNqNDFvLDKsaGisLLIq6Gizt7O87vyt8C2vqGjt6K8/sjLttTIzrrOtO3C
qb75sruz0LWj1PDIzqGjDQo=

