Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F456C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EE3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ER8ULjp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfHSWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:22:38 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:40306 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbfHSWWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:22:38 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x7JMHQw4002057;
        Mon, 19 Aug 2019 23:22:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=969iK0KoMTDmd30EtoPMBUW6pfjiH9io2P6tG8MD6S8=;
 b=ER8ULjp6504ZePYOpbXzhzjyBELAPaOqhAMiPk5uMTP2PAUr7S3z9ptZc0EmXtyAZ0fr
 /w+LBsAb0NxA1z1CqNbiQr1TdeDIUSX1/fI5nV+wh00MHTMPuiV2xw1qgFBlUBtBOoly
 53r4mCkQQYNDIQwYhvGOTWt0F9GqPl67y0hVEBdOoQb26wxx+M/yE3LWPeTqELVQQfkx
 4dl60GDq2BKc6v2anJ+vUDau1C6+dH9aZo8FNiVOzHb/r6fwrDu/Lv/V4E+NpzwuL3Pi
 D6s2H6fC3qek0Dsd9KtuOkqfI4A34Y1zpg0s40+kvMcoQSRHlTqPAsBw9j9lwRshwilF 3g== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 2uea0b38ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 23:22:09 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x7JMGjOV007294;
        Mon, 19 Aug 2019 18:22:08 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.30])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2uecwvb3t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 18:22:08 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) by
 usma1ex-dag1mb2.msg.corp.akamai.com (172.27.123.102) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 19 Aug 2019 18:22:07 -0400
Received: from usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) by
 usma1ex-dag1mb6.msg.corp.akamai.com ([172.27.123.65]) with mapi id
 15.00.1473.005; Mon, 19 Aug 2019 18:22:07 -0400
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        James Morris <jmorris@namei.org>, Leo Yan <leo.yan@linaro.org>
Subject: RE: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Topic: [PATCH v3 3/4] perf: Use CAP_SYSLOG with kptr_restrict checks
Thread-Index: AQHVTS6ohXVeHma7aEyJ5mLyFs0geab7PiSAgAAMNACAAAEdgP//yqiwgAHfTwCAABf5AIAF9+gAgAASvOA=
Date:   Mon, 19 Aug 2019 22:22:07 +0000
Message-ID: <3f70f6be3a464ca5b4cf563433933245@usma1ex-dag1mb6.msg.corp.akamai.com>
References: <cover.1565188228.git.ilubashe@akamai.com>
 <291d2cda6ee75b4cd4c9ce717c177db18bf03a31.1565188228.git.ilubashe@akamai.com>
 <CANLsYkxZE0CQJKQ-bFi=zFV5vTCbL2v76+x1fmCpqNruqWiFXg@mail.gmail.com>
 <20190814184814.GM9280@kernel.org> <20190814185213.GN9280@kernel.org>
 <23f7b8c7616a467c93ee2c77e8ffd3cf@usma1ex-dag1mb6.msg.corp.akamai.com>
 <CANLsYkxqBcJq8QJq+aLZXQas1VBg_wGh_p5WTUuRVFCYEQWiQw@mail.gmail.com>
 <20190815214236.GA3929@kernel.org>
 <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
In-Reply-To: <CANLsYkyPkcJWmBZzyjGj3vJRgEtuaun7HQjN1=5wcOyTPnfhmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.35.136]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190221
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-19_04:2019-08-19,2019-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908190221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWd1c3QgMTksIDIwMTkgYXQgMTI6NTEgUE0gTWF0aGlldSBQb2lyaWVyIDxtYXRo
aWV1LnBvaXJpZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+IE9uIFRodSwgMTUgQXVnIDIwMTkgYXQg
MTU6NDIsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8YXJuYWxkby5tZWxvQGdtYWlsLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBFbSBUaHUsIEF1ZyAxNSwgMjAxOSBhdCAwMjoxNjo0OFBNIC0w
NjAwLCBNYXRoaWV1IFBvaXJpZXIgZXNjcmV2ZXU6DQo+ID4gPiBPbiBXZWQsIDE0IEF1ZyAyMDE5
IGF0IDE0OjAyLCBMdWJhc2hldiwgSWdvciA8aWx1YmFzaGVAYWthbWFpLmNvbT4NCj4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCBBdWd1c3QgMTQsIDIwMTkgYXQgMjo1MiBQTSBB
cm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPGFybmFsZG8ubWVsb0BnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+IEVtIFdlZCwgQXVnIDE0LCAyMDE5IGF0IDAzOjQ4OjE0UE0gLTAzMDAsIEFy
bmFsZG8gQ2FydmFsaG8gZGUNCj4gPiA+ID4gPiBNZWxvDQo+ID4gPiA+ID4gZXNjcmV2ZXU6DQo+
ID4gPiA+ID4gPiBFbSBXZWQsIEF1ZyAxNCwgMjAxOSBhdCAxMjowNDozM1BNIC0wNjAwLCBNYXRo
aWV1IFBvaXJpZXINCj4gZXNjcmV2ZXU6DQo+ID4gPiA+ID4gPiA+ICMgZWNobyAwID4gL3Byb2Mv
c3lzL2tlcm5lbC9rcHRyX3Jlc3RyaWN0ICMNCj4gPiA+ID4gPiA+ID4gLi90b29scy9wZXJmL3Bl
cmYgcmVjb3JkIC1lIGluc3RydWN0aW9uczprIHVuYW1lDQo+ID4gPiA+ID4gPiA+IHBlcmY6IFNl
Z21lbnRhdGlvbiBmYXVsdA0KPiA+ID4gPiA+ID4gPiBPYnRhaW5lZCAxMCBzdGFjayBmcmFtZXMu
DQo+ID4gPiA+ID4gPiA+IC4vdG9vbHMvcGVyZi9wZXJmKHNpZ2hhbmRsZXJfZHVtcF9zdGFjaysw
eDQ0KQ0KPiA+ID4gPiA+ID4gPiBbMHg1NWFmOWU1ZGE1ZDRdDQo+ID4gPiA+ID4gPiA+IC9saWIv
eDg2XzY0LWxpbnV4LWdudS9saWJjLnNvLjYoKzB4M2VmMjApIFsweDdmZDMxZWZiNmYyMF0NCj4g
PiA+ID4gPiA+ID4gLi90b29scy9wZXJmL3BlcmYocGVyZl9ldmVudF9fc3ludGhlc2l6ZV9rZXJu
ZWxfbW1hcCsweGE3KQ0KPiA+ID4gPiA+ID4gPiBbMHg1NWFmOWU1OTAzMzddDQo+ID4gPiA+ID4g
PiA+IC4vdG9vbHMvcGVyZi9wZXJmKCsweDFjZjViZSkgWzB4NTVhZjllNTBjNWJlXQ0KPiA+ID4g
PiA+ID4gPiAuL3Rvb2xzL3BlcmYvcGVyZihjbWRfcmVjb3JkKzB4MTAyMikgWzB4NTVhZjllNTBk
ZmYyXQ0KPiA+ID4gPiA+ID4gPiAuL3Rvb2xzL3BlcmYvcGVyZigrMHgyM2Y5OGQpIFsweDU1YWY5
ZTU3Yzk4ZF0NCj4gPiA+ID4gPiA+ID4gLi90b29scy9wZXJmL3BlcmYoKzB4MjNmYzllKSBbMHg1
NWFmOWU1N2NjOWVdDQo+ID4gPiA+ID4gPiA+IC4vdG9vbHMvcGVyZi9wZXJmKG1haW4rMHgzNjkp
IFsweDU1YWY5ZTRmNmJjOV0NCj4gPiA+ID4gPiA+ID4gL2xpYi94ODZfNjQtbGludXgtZ251L2xp
YmMuc28uNihfX2xpYmNfc3RhcnRfbWFpbisweGU3KQ0KPiA+ID4gPiA+ID4gPiBbMHg3ZmQzMWVm
OTliOTddDQo+ID4gPiA+ID4gPiA+IC4vdG9vbHMvcGVyZi9wZXJmKF9zdGFydCsweDJhKSBbMHg1
NWFmOWU0ZjcwNGFdIFNlZ21lbnRhdGlvbg0KPiA+ID4gPiA+ID4gPiBmYXVsdA0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBJIGNhbiByZXByb2R1Y2UgdGhpcyBvbiBib3RoIHg4NiBhbmQg
QVJNNjQuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSSBkb24ndCBzZWUgdGhpcyB3aXRoIHRo
ZXNlIHR3byBjc2V0cyByZW1vdmVkOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IDdmZjViNTkx
MTE0NCBwZXJmIHN5bWJvbHM6IFVzZSBDQVBfU1lTTE9HIHdpdGgga3B0cl9yZXN0cmljdA0KPiA+
ID4gPiA+ID4gY2hlY2tzIGQ3NjA0YjY2MTAyZSBwZXJmIHRvb2xzOiBVc2UgQ0FQX1NZU19BRE1J
TiB3aXRoDQo+ID4gPiA+ID4gPiBwZXJmX2V2ZW50X3BhcmFub2lkIGNoZWNrcw0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IFdoaWNoIHdlcmUgdGhlIG9uZXMgSSBndWVzc2VkIHdlcmUgcmVsYXRl
ZCB0byB0aGUgcHJvYmxlbSB5b3UNCj4gPiA+ID4gPiA+IHJlcG9ydGVkLCBzbyB0aGV5IGFyZSBv
dXQgb2YgbXkgb25nb2luZyBwZXJmL2NvcmUgcHVsbCByZXF1ZXN0DQo+ID4gPiA+ID4gPiB0byBJ
bmdvL1Rob21hcywgbm93IHRyeWluZyB3aXRoIHRoZXNlIGFwcGxpZWQgYW5kIHlvdXINCj4gaW5z
dHJ1Y3Rpb25zLi4uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDYW4ndCByZXBybzoNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IFtyb290QHF1YWNvIH5dIyBjYXQgL3Byb2Mvc3lzL2tlcm5lbC9rcHRyX3Jl
c3RyaWN0DQo+ID4gPiA+ID4gMA0KPiA+ID4gPiA+IFtyb290QHF1YWNvIH5dIyBwZXJmIHJlY29y
ZCAtZSBpbnN0cnVjdGlvbnM6ayB1bmFtZSBMaW51eCBbIHBlcmYNCj4gcmVjb3JkOg0KPiA+ID4g
PiA+IFdva2VuIHVwIDEgdGltZXMgdG8gd3JpdGUgZGF0YSBdIFsgcGVyZiByZWNvcmQ6IENhcHR1
cmVkIGFuZA0KPiA+ID4gPiA+IHdyb3RlIDAuMDI0IE1CIHBlcmYuZGF0YSAoMSBzYW1wbGVzKSBd
IFtyb290QHF1YWNvIH5dIyBlY2hvIDEgPg0KPiA+ID4gPiA+IC9wcm9jL3N5cy9rZXJuZWwva3B0
cl9yZXN0cmljdCBbcm9vdEBxdWFjbyB+XSMgcGVyZiByZWNvcmQgLWUNCj4gPiA+ID4gPiBpbnN0
cnVjdGlvbnM6ayB1bmFtZSBMaW51eCBbIHBlcmYgcmVjb3JkOiBXb2tlbiB1cCAxIHRpbWVzIHRv
IHdyaXRlDQo+IGRhdGEgXSBbIHBlcmYgcmVjb3JkOg0KPiA+ID4gPiA+IENhcHR1cmVkIGFuZCB3
cm90ZSAwLjAyNCBNQiBwZXJmLmRhdGEgKDEgc2FtcGxlcykgXSBbcm9vdEBxdWFjbw0KPiA+ID4g
PiA+IH5dIyBlY2hvDQo+ID4gPiA+ID4gMCA+IC9wcm9jL3N5cy9rZXJuZWwva3B0cl9yZXN0cmlj
dCBbcm9vdEBxdWFjbyB+XSMgcGVyZiByZWNvcmQNCj4gPiA+ID4gPiAtZSBpbnN0cnVjdGlvbnM6
ayB1bmFtZSBMaW51eCBbIHBlcmYgcmVjb3JkOiBXb2tlbiB1cCAxIHRpbWVzIHRvDQo+ID4gPiA+
ID4gd3JpdGUgZGF0YSBdIFsgcGVyZiByZWNvcmQ6IENhcHR1cmVkIGFuZCB3cm90ZSAwLjAyNCBN
Qg0KPiA+ID4gPiA+IHBlcmYuZGF0YSAoMSBzYW1wbGVzKSBdIFtyb290QHF1YWNvIH5dIw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gW2FjbWVAcXVhY28gcGVyZl0kIGdpdCBsb2cgLS1vbmVsaW5lIC0t
YXV0aG9yIEx1YmFzaGV2IHRvb2xzLw0KPiA+ID4gPiA+IDdmZjViNTkxMTE0NCAoSEVBRCAtPiBw
ZXJmL2NhcCwgYWNtZS5rb3JnL3RtcC5wZXJmL2NhcCwNCj4gPiA+ID4gPiBhY21lLmtvcmcvcGVy
Zi9jYXApIHBlcmYgc3ltYm9sczogVXNlIENBUF9TWVNMT0cgd2l0aA0KPiA+ID4gPiA+IGtwdHJf
cmVzdHJpY3QgY2hlY2tzIGQ3NjA0YjY2MTAyZSBwZXJmIHRvb2xzOiBVc2UgQ0FQX1NZU19BRE1J
Tg0KPiA+ID4gPiA+IHdpdGggcGVyZl9ldmVudF9wYXJhbm9pZCBjaGVja3MgYzc2NmYzZGY2MzVk
IHBlcmYgZnRyYWNlOiBVc2UNCj4gPiA+ID4gPiBDQVBfU1lTX0FETUlOIGluc3RlYWQgb2YgZXVp
ZD09MCBjMjJlMTUwZTNhZmEgcGVyZiB0b29sczogQWRkDQo+ID4gPiA+ID4gaGVscGVycyB0byB1
c2UgY2FwYWJpbGl0aWVzIGlmIHByZXNlbnQNCj4gPiA+ID4gPiA3NGQ1ZjNkMDZmNzAgdG9vbHMg
YnVpbGQ6IEFkZCBjYXBhYmlsaXR5LXJlbGF0ZWQgZmVhdHVyZQ0KPiA+ID4gPiA+IGRldGVjdGlv
biBwZXJmIHZlcnNpb24gNS4zLnJjNC5nN2ZmNWI1OTExMTQ0IFthY21lQHF1YWNvIHBlcmZdJA0K
PiA+ID4gPg0KPiA+ID4gPiBJIGdvdCBhbiBBUk02NCBjbG91ZCBWTSwgYnV0IEkgY2Fubm90IHJl
cHJvZHVjZS4NCj4gPiA+ID4gIyBjYXQgL3Byb2Mvc3lzL2tlcm5lbC9rcHRyX3Jlc3RyaWN0DQo+
ID4gPiA+IDANCj4gPiA+ID4NCj4gPiA+ID4gUGVyZiB0cmFjZSB3b3JrcyBmaW5lIChkb2VzIG5v
dCBkaWUpOg0KPiA+ID4gPiAjIC4vcGVyZiB0cmFjZSAtYQ0KPiA+ID4gPg0KPiA+ID4gPiBIZXJl
IGlzIG15IHNldHVwOg0KPiA+ID4gPiBSZXBvOiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYWNtZS9saW51eC5naXQNCj4gPiA+ID4gQnJhbmNoOiB0bXAucGVy
Zi9jYXANCj4gPiA+ID4gQ29tbWl0OiA3ZmY1YjU5MTEgInBlcmYgc3ltYm9sczogVXNlIENBUF9T
WVNMT0cgd2l0aCBrcHRyX3Jlc3RyaWN0DQo+IGNoZWNrcyINCj4gPiA+ID4gZ2NjIC0tdmVyc2lv
bjogZ2NjIChVYnVudHUvTGluYXJvIDcuNC4wLTF1YnVudHUxfjE4LjA0LjEpIDcuNC4wDQo+ID4g
PiA+IHVuYW1lIC1hOiBMaW51eCBhcm0tNC1wYXItMSA0LjkuOTMtbWFpbmxpbmUtcmV2MSAjMSBT
TVAgVHVlIEFwciAxMA0KPiA+ID4gPiAwOTo1NDo0NiBVVEMgMjAxOCBhYXJjaDY0IGFhcmNoNjQg
YWFyY2g2NCBHTlUvTGludXggbHNiX3JlbGVhc2UNCj4gPiA+ID4gLWE6IFVidW50dSAxOC4wNC4z
IExUUw0KPiA+ID4gPg0KPiA+ID4gPiBBdXRvLWRldGVjdGluZyBzeXN0ZW0gZmVhdHVyZXM6DQo+
ID4gPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICBkd2FyZjogWyBvbiAgXQ0KPiA+ID4g
PiAuLi4gICAgICAgICAgICBkd2FyZl9nZXRsb2NhdGlvbnM6IFsgb24gIF0NCj4gPiA+ID4gLi4u
ICAgICAgICAgICAgICAgICAgICAgICAgIGdsaWJjOiBbIG9uICBdDQo+ID4gPiA+IC4uLiAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ3RrMjogWyBvbiAgXQ0KPiA+ID4gPiAuLi4gICAgICAgICAg
ICAgICAgICAgICAgbGliYXVkaXQ6IFsgb24gIF0NCj4gPiA+ID4gLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgbGliYmZkOiBbIG9uICBdDQo+ID4gPiA+IC4uLiAgICAgICAgICAgICAgICAgICAg
ICAgIGxpYmNhcDogWyBvbiAgXQ0KPiA+ID4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICBs
aWJlbGY6IFsgb24gIF0NCj4gPiA+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICBsaWJudW1h
OiBbIG9uICBdDQo+ID4gPiA+IC4uLiAgICAgICAgbnVtYV9udW1fcG9zc2libGVfY3B1czogWyBv
biAgXQ0KPiA+ID4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgIGxpYnBlcmw6IFsgb24gIF0N
Cj4gPiA+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgbGlicHl0aG9uOiBbIG9uICBdDQo+ID4g
PiA+IC4uLiAgICAgICAgICAgICAgICAgICAgIGxpYmNyeXB0bzogWyBvbiAgXQ0KPiA+ID4gPiAu
Li4gICAgICAgICAgICAgICAgICAgICBsaWJ1bndpbmQ6IFsgb24gIF0NCj4gPiA+ID4gLi4uICAg
ICAgICAgICAgbGliZHctZHdhcmYtdW53aW5kOiBbIG9uICBdDQo+ID4gPiA+IC4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgemxpYjogWyBvbiAgXQ0KPiA+ID4gPiAuLi4gICAgICAgICAgICAg
ICAgICAgICAgICAgIGx6bWE6IFsgb24gIF0NCj4gPiA+ID4gLi4uICAgICAgICAgICAgICAgICAg
ICAgZ2V0X2NwdWlkOiBbIE9GRiBdDQo+ID4gPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJwZjogWyBvbiAgXQ0KPiA+ID4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICBsaWJh
aW86IFsgb24gIF0NCj4gPiA+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICBsaWJ6c3RkOiBb
IG9uICBdDQo+ID4gPiA+IC4uLiAgICAgICAgZGlzYXNzZW1ibGVyLWZvdXItYXJnczogWyBvbiAg
XQ0KPiA+ID4gPg0KPiA+ID4gPiBJIGFsc28gY291bGQgbm90IHJlcHJvZHVjZSBvbiB4ODY6DQo+
ID4gPiA+IGxzYl9yZWxlYXNlIC1hOiBVYnVudHUgMTguMDQuMSBMVFMgZ2NjIC0tdmVyc2lvbjog
Z2NjIChVYnVudHUNCj4gPiA+ID4gNy40LjAtMXVidW50dTF+MTguMDRha2ExMC4wLjApIDcuNC4w
IHVuYW1lIC1yOiA0LjQuMC0xNTQtZ2VuZXJpYw0KPiA+ID4NCj4gPiA+IEkgaXNvbGF0ZWQgdGhl
IHByb2JsZW0gdG8gbGliY2FwLWRldiAtIGlmIGl0IGlzIG5vdCBpbnN0YWxsZWQgYQ0KPiA+ID4g
c2VnbWVudGF0aW9uIGZhdWx0IHdpbGwgb2NjdXIuICBTaW5jZSB0aGlzIHNldCBpcyBhYm91dCB1
c2luZw0KPiA+ID4gY2FwYWJpbGl0aWVzIGl0IGlzIG9idmlvdXMgdGhhdCBub3QgaGF2aW5nIGl0
IG9uIGEgc3lzdGVtIHNob3VsZA0KPiA+ID4gZmFpbCBhIHRyYWNlIHNlc3Npb24sIGJ1dCBpdCBz
aG91bGQgbm90IGNyYXNoIGl0Lg0KPiA+DQo+ID4gSXQgc2hvdWxkbid0IGNyYXNoIG9uIHg4Nl82
NDoNCj4gPg0KPiA+IHJvb3RAcXVhY28gfl0jIHN5c2N0bCBrZXJuZWwua3B0cl9yZXN0cmljdCBr
ZXJuZWwua3B0cl9yZXN0cmljdCA9IDANCj4gPiBbcm9vdEBxdWFjbyB+XSMgcGVyZiByZWNvcmQg
LWUgaW5zdHJ1Y3Rpb25zOmsgdW5hbWUgTGludXggWyBwZXJmDQo+ID4gcmVjb3JkOiBXb2tlbiB1
cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXSBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQNCj4g
PiB3cm90ZSAwLjAyMyBNQiBwZXJmLmRhdGEgKDUgc2FtcGxlcykgXSBbcm9vdEBxdWFjbyB+XSMg
bGRkIH4vYmluL3BlcmYNCj4gPiB8IGdyZXAgbGliY2FwIFtyb290QHF1YWNvIH5dIyBwZXJmIC12
IHBlcmYgdmVyc2lvbg0KPiA+IDUuMy5yYzQuZzMyOWNhMzMwYmY4YiBbcm9vdEBxdWFjbyB+XSMg
W2FjbWVAcXVhY28gcGVyZl0kIGdpdCBsb2cNCj4gPiAtLW9uZWxpbmUgLTQgMzI5Y2EzMzBiZjhi
IChIRUFEIC0+IHBlcmYvY2FwKSBwZXJmIHN5bWJvbHM6IFVzZQ0KPiA+IENBUF9TWVNMT0cgd2l0
aCBrcHRyX3Jlc3RyaWN0IGNoZWNrcyBmN2I5OTk5Mzg3YWYgcGVyZiB0b29sczogVXNlDQo+ID4g
Q0FQX1NZU19BRE1JTiB3aXRoIHBlcmZfZXZlbnRfcGFyYW5vaWQgY2hlY2tzDQo+ID4gNGQwNDg5
Y2YxYzQ3IChhY21lLmtvcmcvdG1wLnBlcmYvc2NyaXB0LXN3aXRjaC1vbi1vZmYsIHBlcmYvY29y
ZSkgcGVyZg0KPiA+IHJlcG9ydDogQWRkIC0tc3dpdGNoLW9uLy0tc3dpdGNoLW9mZiBldmVudHMN
Cj4gPiAyZjUzYWUzNDdmNTkgcGVyZiB0b3A6IEFkZCAtLXN3aXRjaC1vbi8tLXN3aXRjaC1vZmYg
ZXZlbnRzIFthY21lQHF1YWNvDQo+ID4gcGVyZl0kDQo+ID4NCj4gPiA+IElmIGxpYmNhcC1kZXYg
aXMgbm90IGluc3RhbGxlZCBmdW5jdGlvbg0KPiA+ID4gc3ltYm9sX19yZXN0cmljdGVkX2ZpbGVu
YW1lKCkgd2lsbCByZXR1cm4gdHJ1ZSwgd2hpY2ggaW4gdHVybiB3aWxsDQo+ID4gPiBwcmV2ZW50
IHN5bWJvbF9uYW1lIHRvIGJlIHNldCBpbg0KPiA+ID4gbWFjaGluZV9fZ2V0X3J1bm5pbmdfa2Vy
bmVsX3N0YXJ0KCkuICBUaGF0IHByZXZlbnRzIGZ1bmN0aW9uDQo+ID4gPiBtYXBfX3NldF9rYWxs
c3ltc19yZWZfcmVsb2Nfc3ltKCkgZnJvbSBiZWluZyBjYWxsZWQgaW4NCj4gPiA+IG1hY2hpbmVf
X2NyZWF0ZV9rZXJuZWxfbWFwcygpLCByZXN1bHRpbmcgaW4ga21hcC0+cmVmX3JlbG9jX3N5bQ0K
PiA+ID4gYmVpbmcgTlVMTCBpbiBfcGVyZl9ldmVudF9fc3ludGhlc2l6ZV9rZXJuZWxfbW1hcCgp
IGFuZCBhDQo+ID4gPiBzZWdtZW50YXRpb24gZmF1bHQuDQo+ID4NCj4gPiBDYW4geW91IHBsZWFz
ZSB0cnkgd2l0aCBteSBwZXJmL2NhcCBicmFuY2g/IFBlcmhhcHMgeW91J3JlIHVzaW5nDQo+ID4g
SWdvcidzIG9yaWdpbmFsIHNldCBvZiBwYXRjaGVzPyBJIG1hZGUgY2hhbmdlcyB0byB0aGUgZmFs
bGJhY2ssIGhlIHdhcw0KPiA+IG1ha2luZyBpdCByZXR1cm4gZmFsc2Ugd2hpbGUgSSBtYWRlIGl0
IGZhbGxiYWNrIHRvIGdldGV1aWQoKSA9PSAwLCBhcw0KPiA+IHdhcyBiZWZvcmUgaGlzIHBhdGNo
ZXMuDQo+IA0KPiBUaGluZ3MgYXJlIHdvcmtpbmcgcHJvcGVybHkgb24geW91ciBwZXJmL2NhcCBi
cmFuY2guICBJIHRlc3RlZCB3aXRoIG9uIGJvdGgNCj4geDg2IGFuZCBBUk0uDQoNCk1hdGhpZXUs
IHlvdSBhcmUgcHJvYmFibHkgdGVzdGluZyB3aXRoIGV1aWQ9PTAuICBJZiB5b3Ugd2VyZSB0byB0
ZXN0IHdpdGggZXVpZCE9MCBidXQgd2l0aCBDQVBfU1lTTE9HIGFuZCBubyBsaWJjYXAgKGFuZCBr
cHRyX3Jlc3RyaWN0PTAsIHBlcmZfZXZlbnRfcGFyYW5vaWQ9MiksIHlvdSB3b3VsZCBsaWtlbHkg
aGl0IHRoZSBidWcgdGhhdCB5b3UgaWRlbnRpZmllZCBpbiBfX3BlcmZfZXZlbnRfX3N5bnRoZXNp
emVfa2VybWVsX21tYXAoKS4NCg0KU2VlIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL2xrbWwvOTMw
YTU5NzMwYzBkNDk1ZjhjNWFjZjRmOTkwNDhlOGRAdXNtYTFleC1kYWcxbWI2Lm1zZy5jb3JwLmFr
YW1haS5jb20gZm9yIHRoZSBmaXggKE9wdGlvbiAxIG9ubHkgb3IgT3B0aW9ucyAxKzIpLg0KDQpB
cm5hbGRvLCBvbmNlIHdlIGRlY2lkZSB3aGF0IHRoZSByaWdodCBmaXggaXMsIEkgYW0gaGFwcHkg
dG8gcG9zdCB0aGUgdXBkYXRlIChvcHRpb25zIDEsIDErMikgYXMgYSBwYXRjaCBzZXJpZXMuDQoN
Ci0gSWdvcg0KDQoNCj4gPiA+IEkgYW0gbm90IHN1cmUgaG93IHRoaXMgY2FuIGJlIGZpeGVkLiAg
SSBjb3VudGVkIGEgdG90YWwgb2YgMTkNCj4gPiA+IGluc3RhbmNlcyB3aGVyZSBrbWFwLT5yZWZf
cmVsb2Nfc3ltLT5YWVogaXMgY2FsbGVkLCBvbmx5IDIgb2Ygd2ljaA0KPiA+ID4gY2FyZSB0byBj
aGVjayBpZiBrbWFwLT5yZWZfcmVsb2Nfc3ltIGlzIHZhbGlkIGJlZm9yZSBwcm9jZWVkaW5nLiAg
QXMNCj4gPiA+IHN1Y2ggSSBtdXN0IGhvcGUgdGhhdCBpbiB0aGUgMTcgb3RoZXIgY2FzZXMsIGtt
YXAtPnJlZl9yZWxvY19zeW0gaXMNCj4gPiA+IGd1YXJhbnRlZWQgdG8gYmUgdmFsaWQuICBJZiBJ
IGFtIGNvcnJlY3QgdGhlbiBhbGwgd2UgbmVlZCBpcyB0bw0KPiA+ID4gY2hlY2sgZm9yIGEgdmFs
aWQgcG9pbnRlciBpbiBfcGVyZl9ldmVudF9fc3ludGhlc2l6ZV9rZXJuZWxfbW1hcCgpLg0KPiA+
ID4gT3RoZXJ3aXNlIGl0IHdpbGwgYmUgYSBsaXR0bGUgaGFyZGVyLg0KPiA+ID4NCj4gPiA+IE1h
dGhpZXUNCg0K
