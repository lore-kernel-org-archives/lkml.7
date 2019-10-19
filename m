Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002FCA9EA9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1520663
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 00:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="EzjdOPCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfJSAo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 20:44:59 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:29902 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbfJSAo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 20:44:59 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id x9J0R3gg030768;
        Sat, 19 Oct 2019 01:44:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=jan2016.eng;
 bh=5lFAg/Jjollhd/FDcl66OJhCcm9dwpE6QVxlWd9Hr7o=;
 b=EzjdOPCruqbcdZWSgQ9dHNdtxotlYt354Fb8FbriaY86WUHW7xtczzgHaaTNKtkLrivU
 LUjv3Id1dp18i1ayU4I+uuZNmb7A4thBvvVTcU4kil5hw90ZbNuGmXLEnpgyvZTep8j3
 Aaq3k1R8D8+3MFRIZzIFqO+nq0q9Se9mlXpc76Ts03kYqFDcqEzi0qvBZLJN+rVwwtEU
 EHKgpWxg0NUfAAtr+3OdwXdRISpIv/OLy9YQ6ETxhtKkF9xZYXyrzxnN9lOEuNBqHUiA
 aEbbgaeBLiRYwfcmTXOktPIy7hUlEeRQtwXj3OSDx8rV6C7DvCqt+6rnUtVK7XlIw4gj Bw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2vnp4ws6pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Oct 2019 01:44:45 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x9J0WLGM027015;
        Fri, 18 Oct 2019 20:44:43 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2vka5xp4sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 20:44:43 -0400
Received: from usma1ex-dag3mb5.msg.corp.akamai.com (172.27.123.55) by
 usma1ex-dag3mb4.msg.corp.akamai.com (172.27.123.56) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Fri, 18 Oct 2019 20:44:42 -0400
Received: from usma1ex-dag3mb5.msg.corp.akamai.com ([172.27.123.55]) by
 usma1ex-dag3mb5.msg.corp.akamai.com ([172.27.123.55]) with mapi id
 15.00.1473.005; Fri, 18 Oct 2019 20:44:42 -0400
From:   "Zhivich, Michael" <mzhivich@akamai.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] clocksource: tsc: respect tsc bootparam for
 clocksource_tsc_early
Thread-Topic: [PATCH] clocksource: tsc: respect tsc bootparam for
 clocksource_tsc_early
Thread-Index: AQHVeSvop8BjZQxpKEir2d628u1V9qdhF/MAgAAifoA=
Date:   Sat, 19 Oct 2019 00:44:42 +0000
Message-ID: <DDD67E2B-F721-49AF-8889-8AD57ACDA190@akamai.com>
References: <20191002141553.7682-1-mzhivich@akamai.com>
 <alpine.DEB.2.21.1910181953120.1869@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910181953120.1869@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.32.124]
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha256; boundary="B_3654276282_1320366360"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_06:2019-10-18,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--B_3654276282_1320366360
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit

On 10/18/19, 2:41 PM, "Thomas Gleixner" <tglx@linutronix.de> wrote:

> On Wed, 2 Oct 2019, Michael Zhivich wrote:
> > Introduction of clocksource_tsc_early broke functionality of "tsc=reliable"
> > and "tsc=nowatchdog" boot params, since clocksource_tsc_early is *always*
> > registered with CLOCK_SOURCE_MUST_VERIFY and thus put on the watchdog list.
> > 
> > If CPU is very busy during boot, the watchdog clocksource may not be
> > read frequently enough, resulting in a large difference that is treated as
> > "negative" by clocksource_delta() and incorrectly truncated to 0.
> 
> What? 
> 
> >   clocksource: timekeeping watchdog on CPU1: Marking clocksource
> >                'tsc-early' as unstable because the skew is too large:
> >   clocksource: 'refined-jiffies' wd_now: fffb7019 wd_last: fffb6e28
> 
>     0xfffb7019 - 0xfffb6e28 = 497
> 
> What's treated negative there? And what would truncate that to 0?
> 
> >                 mask: ffffffff
> 
> A 'negative delta' value can only happen when the clocksource is not read
> before it advanced more than mask/2. For jiffies this means 2^31
> ticks. That would be ~248 days for HZ=100 or ~24 days for HZ=1000.
> 
> >   clocksource: 'tsc-early' cs_now: 52c3918b89d6 cs_last: 52c31d736d2e
> 
>   0x52c3918b89d6 - 0x52c31d736d2e = 1.94774e+09
> 
> Again nothing is treated negative here, but the point is that the TSC
> advanced by ~2e9 cycles while jiffies advanced by 497.
> 
> How that's related, I can't tell because I don't know the TSC frequency of
> your machine. HZ is probably 1000 as the watchdog period is HZ/2.
> 
> >                 mask: ffffffffffffffff
> >   tsc: Marking TSC unstable due to clocksource watchdog
> 
> Even if the watchdog is not read out for a quite some time, the math in
> there and in clocksource_delta() can handle pretty large deltas.
> 
> The watchdog triggers when
> 
>     abs(delta_watchdog - delta_tsc) > 0.0625 seconds
> 
> So that has absolutely nothing to do with CPU being busy and watchdog not
> being serviced. jiffies and TSC drift apart for some reason, and that
> reason wants to be documented in the changelog.
> 
> That said, I have no objections against the patch itself, but I'm not going
> to apply a patch with a fairy tale changelog.
> 
> Thanks,
> 
> 	tglx
>     

Thanks for taking a look.  I agree that the commit message explanation is bogus; I had
incorrectly assumed that the issue was similar to what I've seen with acpi_pm based
watchdog before and didn't check the numbers carefully.

I'll rework the commit message and resubmit.

Thanks,
~ Michael

--B_3654276282_1320366360
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIINnwYJKoZIhvcNAQcCoIINkDCCDYwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggt6MIIFOzCCBOGgAwIBAgITFwAFBZzE/M7OVP1k6QAAAAUFnDAKBggqhkjOPQQDAjA8
MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNs
aWVudENBMB4XDTE5MDUwNzE2NDQ1NFoXDTIwMDUwMTE2NDQ1NFowbjEcMBoGA1UEChMTQWth
bWFpIFRlY2hub2xvZ2llczEXMBUGA1UECxMOQVVUTy1ib3MtbXBtemIxETAPBgNVBAMTCG16
aGl2aWNoMSIwIAYJKoZIhvcNAQkBFhNtemhpdmljaEBha2FtYWkuY29tMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2c3+Dv2rivY3TXngv702PsZvkfFkrtwi9MxHD0IQp/w4
iBmv3HksNByay+R7FpR35XCyDLIVWJpRoXH9DBCX+v0vuHJO8p+p7hdO+NFtOts7zXimMG5O
PB4OknKAQVrgc7894g/baum6yBAjYjoorm7rdNyNicht1h4qsGfWdKFEeGddyxirItqrQrgh
ZKnrmCfH7l2vgl8Khakj+hKmKN1/QphvVXejxh/C7Uqpx8XE4JRJIrW+ZVTq0BweR0bpZMYp
8wdojMDp4WvzNSZFmoTCjE3tOYUIb2vcnpKGCli8Gg2MSBLBItnukuF5WFwQ+AkO4Gcj+8B1
qcWo1jHjdQIDAQABo4ICwzCCAr8wCwYDVR0PBAQDAgWgMDMGA1UdJQQsMCoGCCsGAQUFBwMH
BggrBgEFBQcDAgYKKwYBBAGCNwoDBAYIKwYBBQUHAwQwMwYDVR0RBCwwKqAoBgorBgEEAYI3
FAIDoBoMGG16aGl2aWNoQGNvcnAuYWthbWFpLmNvbTAdBgNVHQ4EFgQUaVksRyvyLfsrzz8j
zxF5231ZUc0wHwYDVR0jBBgwFoAUk4erMWaQ2spNFgOM5MMPveYNLAwwegYDVR0fBHMwcTBv
oG2ga4YuaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBLmNybIY5
aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0Eu
Y3JsMIHCBggrBgEFBQcBAQSBtTCBsjA6BggrBgEFBQcwAoYuaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBLmNydDBFBggrBgEFBQcwAoY5aHR0cDovL2FrYW1h
aWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EuY3J0MC0GCCsGAQUF
BzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2FtYWkuY29tL29jc3AwPAYJKwYBBAGCNxUHBC8w
LQYlKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIPgUmE5N8FgZD6FAIBZAIBGzBBBgkrBgEE
AYI3FQoENDAyMAoGCCsGAQUFBwMHMAoGCCsGAQUFBwMCMAwGCisGAQQBgjcKAwQwCgYIKwYB
BQUHAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCA
MAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIEFG/5BViZGTiIUSkswF
l54TS+PbVgRBJrMQfCEcMM0KAiEAwgbtfH/ziltYQwXQgyXE6NJ4tDUmt6jSf2BIWm+whdcw
ggRmMIIEC6ADAgECAhM+AAAACuqzGxBold1TAAAAAAAKMAoGCCqGSM49BAMCMD8xITAfBgNV
BAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3Qt
RzEwHhcNMTUwNjA0MTQ0NjA3WhcNMjUwNjA0MTQ1NjA3WjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0C
AQYIKoZIzj0DAQcDQgAEpuPNNA/ZEjWEkhjgWrKAipOQ72FwxtH8l6tvtbIFC5IfpXFiAN5Y
B//ydeR3aM1Xk9l/JOQlbwOuOtNP7UgZoqOCAucwggLjMBAGCSsGAQQBgjcVAQQDAgEAMB0G
A1UdDgQWBBSTh6sxZpDayk0WA4zkww+95g0sDDCBsAYDVR0gBIGoMIGlMIGiBgsqAwSPTgEJ
CQgBATCBkjBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABDAGUAcgB0AGkAZgBpAGMA
YQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4AdDA2BggrBgEFBQcC
ARYqaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYAMFUGA1UdJQRO
MEwGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYKKwYBBAGC
NwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMJMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsG
A1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFK0Bh+rcWa6xEzmVTQ9X
oCSGi3u9MIGABgNVHR8EeTB3MHWgc6BxhjFodHRwOi8vYWthbWFpY3JsLmFrYW1haS5jb20v
QWthbWFpQ29ycFJvb3QtRzEuY3JshjxodHRwOi8vYWthbWFpY3JsLmRmdzAxLmNvcnAuYWth
bWFpLmNvbS9Ba2FtYWlDb3JwUm9vdC1HMS5jcmwwgcgGCCsGAQUFBwEBBIG7MIG4MC0GCCsG
AQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2FtYWkuY29tL29jc3AwPQYIKwYBBQUHMAKG
MWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDb3JwUm9vdC1HMS5jcnQwSAYI
KwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWkuY29tL0FrYW1h
aUNvcnBSb290LUcxLmNydDAKBggqhkjOPQQDAgNJADBGAiEAxb2BDEI5u7VpG4TgR0KbsktK
aQOiFL6T6KtkAx7D8xACIQDJXMn85cVLMHcRe3wdfR/6Nr0ofAejZ6IaKj34qkK5KzCCAc0w
ggFzoAMCAQICEBWwiAMHXDS7Q8DxTR/GKBEwCgYIKoZIzj0EAwIwPzEhMB8GA1UEChMYQWth
bWFpIFRlY2hub2xvZ2llcyBJbmMuMRowGAYDVQQDExFBa2FtYWlDb3JwUm9vdC1HMTAeFw0x
NTA1MDUxODA5MjBaFw00MDA1MDUxODE5MjBaMD8xITAfBgNVBAoTGEFrYW1haSBUZWNobm9s
b2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwWTATBgcqhkjOPQIBBggq
hkjOPQMBBwNCAARlk5NoCPduAuWtjE9cFFfGYSzz6+kqS2Ys/LckQf2pPv6ZBFThRFEZhdbH
6JqzeS9Kdz/zOm3WPOOEa01s2l6Zo1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB
/zAdBgNVHQ4EFgQUrQGH6txZrrETOZVND1egJIaLe70wEAYJKwYBBAGCNxUBBAMCAQAwCgYI
KoZIzj0EAwIDSAAwRQIgKY8PO2tJ89kGAIPZLEJXCa0fVRPBYoF9LGIEQGBDQjECIQDlbB4a
rnvZHK7HN0fpn72P1/DsFpmhjVXhJMmX3Ev4hTGCAekwggHlAgEBMFMwPDEhMB8GA1UEChMY
QWthbWFpIFRlY2hub2xvZ2llcyBJbmMuMRcwFQYDVQQDEw5Ba2FtYWlDbGllbnRDQQITFwAF
BZzE/M7OVP1k6QAAAAUFnDANBglghkgBZQMEAgEFAKBpMC8GCSqGSIb3DQEJBDEiBCDEUTI9
uoc2TLMfJspt8XZ+COn2WkGvEN0BQ6FpuN7eezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xOTEwMTkwMDQ0NDFaMA0GCSqGSIb3DQEBAQUABIIBAG66WQtM
Ye8L6f//fTWtUv/TqV6B5y2Cm/SisKNtGtDQPTyCxjN5cBIv7C/QyztJllMSE5rAix+oyyRm
GRU9fIUmBvS8T0QymkqE7Ha7sb6MQU5I09CmS9AWBB4fk9qE+GfGqDa47JIa7o+aGwmjB//U
VkN+q4BZzSK2z4pwnbUjY68zbtzhCuIgTRsZxm8SoT+5loqu1yHczF/B5lg3mjLOUODpY/Pj
4dcW9F6fStoyDsPkKP5uFXCDQEUH2DUH0j+ia1fS7p+a5FxaoNL4x9DnUXFKUhVSrlA2GubB
8hATHyowxOlbzFk4yoEpnFUOHZ8UJ2yBrAuR0S4iebF4dcc=

--B_3654276282_1320366360--
